part of '../data.dart';

const _apiBaseUrl = String.fromEnvironment(
  "API_BASE_URL",
  defaultValue: "https://api.barakaposystem.uz/api",
);
const _refreshPath = "/auth/token/refresh/";
const _retriedFlag = "retried_after_refresh";

class DioClient {
  final Talker talker;

  DioClient({required this.talker});

  /// Bir vaqtda faqat bitta refresh so'rovi ketadi (splash va 401 interceptor
  /// ham shu yerdan o'tadi). Backend refresh tokenni har safar almashtirib,
  /// eskisini blacklist qiladi — ikkita parallel so'rov foydalanuvchini chiqarib yuboradi.
  static Future<_RefreshResult>? _pendingRefresh;

  /// Ilova ochilganda tokenni va foydalanuvchi ma'lumotini yangilash
  static Future<void> refreshTokens() async {
    final result = await _refreshAccessToken();
    if (result is _RefreshRejected) await _forceLogout();
  }

  Dio createDioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _apiBaseUrl,
        contentType: "application/json",
        sendTimeout: Duration(seconds: 20),
        connectTimeout: kIsWeb ? Duration.zero : Duration(seconds: 20),
        receiveTimeout: kIsWeb ? Duration.zero : Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final local = AuthLocalSource(PosLocalDatabase.instance);
          final auth = await local.getCurrentAuth();
          final token = auth?.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          final context = rootNavigatorKey.currentContext;
          if (context != null) {
            // ignore: use_build_context_synchronously
            final currentLocale = EasyLocalization.of(context)?.locale;
            if (currentLocale != null) {
              options.headers['Accept-Language'] = currentLocale.languageCode;
            }
          }

          handler.next(options);
        },
        onError: (DioException error, handler) async {
          final status = error.response?.statusCode;

          if (status == 403) {
            rootNavigatorKey.currentContext?.go('/forbidden');
            return handler.next(error);
          }

          if (status != 401) return handler.next(error);

          final options = error.requestOptions;
          final alreadyRetried = options.extra[_retriedFlag] == true;

          if (alreadyRetried || options.path.contains(_refreshPath)) {
            await _forceLogout();
            return handler.next(error);
          }

          final result = await _refreshAccessToken();

          final String newToken;
          switch (result) {
            case _RefreshSuccess(:final access):
              newToken = access;
            case _RefreshRejected():
              await _forceLogout();
              return handler.next(error);
            case _RefreshNetworkError():
              // Internet yo'q / server javob bermadi — chiqarib yubormaymiz
              return handler.next(error);
          }

          options.extra[_retriedFlag] = true;
          options.headers['Authorization'] = 'Bearer $newToken';

          try {
            return handler.resolve(await dio.fetch(options));
          } catch (_) {
            return handler.next(error);
          }
        },
      ),
    );

    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          hiddenHeaders: {"Authorization"},
        ),
      ),
    );

    return dio;
  }

  static Future<_RefreshResult> _refreshAccessToken() {
    return _pendingRefresh ??=
        _performRefresh().whenComplete(() => _pendingRefresh = null);
  }

  static Future<_RefreshResult> _performRefresh() async {
    final local = AuthLocalSource(PosLocalDatabase.instance);
    final auth = await local.getCurrentAuth();
    final refreshToken = auth?.refreshToken;

    if (refreshToken == null || refreshToken.isEmpty) {
      return const _RefreshRejected();
    }

    final client = Dio(
      BaseOptions(
        baseUrl: _apiBaseUrl,
        contentType: "application/json",
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    final Response<Json> response;
    try {
      response = await client.post<Json>(
        _refreshPath,
        data: {"refresh": refreshToken},
      );
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 400 || status == 401) {
        // Boshqa tab yoki so'rov tokenni bizdan oldin yangilagan bo'lishi mumkin
        final latest = await local.getCurrentAuth();
        if (latest != null && latest.refreshToken != refreshToken) {
          return _RefreshSuccess(latest.accessToken);
        }
        return const _RefreshRejected();
      }
      return const _RefreshNetworkError();
    } catch (_) {
      return const _RefreshNetworkError();
    }

    final body = switch (response.data) {
      {"data": Json data} => data,
      Json data => data,
      _ => null,
    };

    final access = body?["access"];
    if (body == null || access is! String || access.isEmpty) {
      return const _RefreshNetworkError();
    }

    final user = body["user"];
    await local.updateTokens(
      accessToken: access,
      refreshToken: body["refresh"] is String ? body["refresh"] : refreshToken,
      userJson: user is Json ? user : null,
    );
    globalUser = await local.getCurrentUser();

    return _RefreshSuccess(access);
  }

  static Future<void> _forceLogout() async {
    await AuthLocalSource(PosLocalDatabase.instance).logout();
    globalUser = null;
    rootNavigatorKey.currentContext?.go('/auth');
  }
}

sealed class _RefreshResult {
  const _RefreshResult();
}

final class _RefreshSuccess extends _RefreshResult {
  final String access;
  const _RefreshSuccess(this.access);
}

/// Server refresh tokenni rad etdi (muddati o'tgan / blacklist) — qayta kirish kerak
final class _RefreshRejected extends _RefreshResult {
  const _RefreshRejected();
}

/// Internet yoki server xatosi — tokenlar joyida qoladi
final class _RefreshNetworkError extends _RefreshResult {
  const _RefreshNetworkError();
}
