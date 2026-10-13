import 'package:baraka_pos/shared/shared.dart';

/// Oddiy JSON so'rovlar uchun: alohida DTO/payload talab qilmaydigan
/// kichik amallar (qarzdor yaratish, sotuvni tahrirlash...)
final class JsonBodyPayload extends Payload {
  final Json body;
  final Map<String, String> params;

  const JsonBodyPayload({this.body = const {}, this.params = const {}});

  @override
  List<String> get props => ["body: $body", "params: $params"];
}

final class JsonBodyRequest extends RemoteRequest<JsonBodyPayload> {
  final Json body;
  final Map<String, String> params;

  JsonBodyRequest.fromPayload(super.payload)
      : body = payload.body,
        params = payload.params,
        super.fromPayload();

  @override
  Json data() => body;

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => params;
}

final class ApiJsonSource extends RemoteSource {
  ApiJsonSource({required super.client});

  JsonBodyRequest _request(Json body, Map<String, String> params) =>
      JsonBodyRequest.fromPayload(JsonBodyPayload(body: body, params: params));

  Future<Safed<BaseException, Json>> get(String path,
          {Map<String, String> params = const {}}) =>
      apiGet(path: path, request: _request(const {}, params));

  Future<Safed<BaseException, Json>> post(String path, Json body) =>
      apiPost(path: path, request: _request(body, const {}));

  Future<Safed<BaseException, Json>> patch(String path, Json body) =>
      apiPatch(path: path, request: _request(body, const {}));
}
