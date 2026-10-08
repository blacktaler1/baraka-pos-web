part of '../data.dart';

abstract class RemoteSource {
  @protected
  final Dio client;

  RemoteSource({required this.client});

  @protected
  D Function(Json json) dataFactory<D extends JsonDto>(
    D Function(Json json) factory,
  ) {
    return (json) => factory(switch (json) {
          {"data": Json data} => data,
          _ => json,
        });
  }

  @protected
  Future<Safed<BaseException, Json>> apiGet({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'GET',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiPost({
    required String path,
    required RemoteRequest request,
    Duration? receiveTimeout,
  }) async {
    return apiFetch(
      path: path,
      method: 'POST',
      request: request,
      receiveTimeout: receiveTimeout,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiPatch({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'PATCH',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiPut({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'PUT',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiDelete({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'DELETE',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiPostMultipart({
    required String path,
    required FormData formData,
  }) async {
    try {
      final response = await client.post<Json>(
        path,
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      if (response.data case Json json) return Success(json);

      return Failure(
        NetworkException(
          title: "Invalid response",
          description: "The response is not a valid JSON object"
              ":\n${response.data}",
          code: response.statusCode ?? 0,
        ),
      );
    } on DioException catch (e) {
      return Failure(
        NetworkException(
          title: "Network error",
          description: e.message ?? 'Unknown error',
          code: e.response?.statusCode ?? 0,
        ),
      );
    } catch (e) {
      return Failure(
        NetworkException(
          title: "Unknown error",
          description: e.toString(),
          code: 0,
        ),
      );
    }
  }

  @protected
  Future<Safed<BaseException, Uint8List>> apiDownload({
    required String path,
    required RemoteRequest request,
  }) async {
    try {
      final response = await client.get<List<int>>(
        path,
        queryParameters: request.query(),
        options: Options(responseType: ResponseType.bytes),
      );
      return Success(Uint8List.fromList(response.data ?? const []));
    } on DioException catch (e) {
      return Failure(
        NetworkException(
          title: "Network error",
          description: e.message,
          code: e.response?.statusCode ?? 0,
        ),
      );
    }
  }

  String _badRequestMessage(Map<String, dynamic> data) {
    final detail = data['detail'];
    if (detail is String) return detail;
    if (detail is List) return detail.join('\n');

    List<String> collect(dynamic value) => switch (value) {
          String text => [text],
          List list => list.expand(collect).toList(),
          {'row': final row, 'errors': final errors} => [
              "${tr('row')} $row: ${collect(errors).join(', ')}"
            ],
          Map map => map.values.expand(collect).toList(),
          _ => const <String>[],
        };

    final messages = collect(data);
    return messages.isEmpty ? 'Bad request' : messages.join('\n');
  }

  @protected
  Future<Safed<BaseException, Json>> apiFetch({
    required String path,
    required String method,
    required RemoteRequest request,
    Duration? receiveTimeout,
  }) async {
    try {
      final computedPath = request.path().entries.fold(
            path,
            (computed, entry) =>
                computed.replaceAll('{${entry.key}}', entry.value),
          );

      if (computedPath.startsWith('//') || computedPath.contains('/null/')) {
        return Failure(
          ApiException(
            message: "Do'kon ma'lumoti topilmadi. Tizimga qayta kiring.",
            code: 0,
          ),
        );
      }

      final response = await client.fetch<Json>(
        Options(
          method: method,
          responseType: ResponseType.json,
          receiveTimeout: receiveTimeout,
        ).compose(
          client.options,
          computedPath,
          queryParameters: request.query(),
          data: method.toLowerCase() == 'get'
              ? null
              : await request.form() ?? request.data(),
          cancelToken: request.cancelToken,
          onSendProgress: request.onSendProgress,
          onReceiveProgress: request.onReceiveProgress,
        ),
      );

      if ([204, 205, 304].contains(response.statusCode)) {
        return Success(<String, dynamic>{});
      }

      if (response.data case Json json) {
        return Success(json);
      }

      return Failure(
        NetworkException(
          title: "Invalid response",
          description:
              "The response is not a valid JSON object:\n${response.data}",
          code: response.statusCode ?? 0,
        ),
      );
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;

      //  422 VALIDATION
      if (status == 422 && data is Json) {
        final error = data['error'];
        if (error is Json) {
          final rawFields = error['fields'];

          return Failure(
            FormValidationException(
              message: error.text('message', fallback: "Validation error"),
              fields: rawFields is Json
                  ? rawFields.map(
                      (k, v) => MapEntry(
                        k,
                        v is List
                            ? v.map((e) => e.toString()).toList()
                            : <String>[v.toString()],
                      ),
                    )
                  : <String, List<String>>{},
            ),
          );
        }
      }

      //  400 BAD REQUEST
      if (status == 400 && data is Map<String, dynamic>) {
        return Failure(
          ApiException(
              message: _badRequestMessage(data), code: 400, data: data),
        );
      }

      //  404
      if (status == 404 && data is Map<String, dynamic>) {
        final detail = data['detail'];
        if (detail is String) {
          return Failure(NotFoundException(message: detail));
        }
      }

      //  401
      if (status == 401) {
        return Failure(
          ApiException(message: "Unauthorized", code: 401, data: data),
        );
      }

      //  403
      if (status == 403 && data is Map<String, dynamic>) {
        final detail = data['detail'];
        return Failure(
          ApiException(
            message: detail is String ? detail : "Access denied",
            code: 403,
            data: data,
          ),
        );
      }

      return Failure(
        NetworkException(
          title: "Network error",
          description: e.message,
          code: status ?? 0,
        ),
      );
    } catch (e) {
      return Failure(
        NetworkException(
          title: "Unknown error",
          description: e.toString(),
          code: 0,
        ),
      );
    }
  }
}
