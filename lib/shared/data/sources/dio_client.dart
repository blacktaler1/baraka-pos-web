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

  Future<String?>? _pendingRefresh;

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

          final newToken = await _refreshAccessToken();

          if (newToken == null) {
            await _forceLogout();
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

  Future<String?> _refreshAccessToken() {
    return _pendingRefresh ??=
        _performRefresh().whenComplete(() => _pendingRefresh = null);
  }

  Future<String?> _performRefresh() async {
    final local = AuthLocalSource(PosLocalDatabase.instance);
    final auth = await local.getCurrentAuth();
    final refreshToken = auth?.refreshToken;

    if (refreshToken == null || refreshToken.isEmpty) return null;

    try {
      final client = Dio(
        BaseOptions(
          baseUrl: _apiBaseUrl,
          contentType: "application/json",
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
        ),
      );

      final response = await client.post<Json>(
        _refreshPath,
        data: {"refresh": refreshToken},
      );

      final body = switch (response.data) {
        {"data": Json data} => data,
        Json data => data,
        _ => null,
      };

      if (body == null) return null;

      final access = body["access"];
      if (access is! String || access.isEmpty) return null;

      final user = body["user"];
      if (user is Json) {
        await local.updateTokens(
          accessToken: access,
          refreshToken:
              body["refresh"] is String ? body["refresh"] : refreshToken,
          userJson: user,
        );
        globalUser = await local.getCurrentUser();
      }

      return access;
    } catch (_) {
      return null;
    }
  }

  Future<void> _forceLogout() async {
    await AuthLocalSource(PosLocalDatabase.instance).logout();
    globalUser = null;
    rootNavigatorKey.currentContext?.go('/auth');
  }
}
