import 'package:baraka_pos/features/auth/domain/payload/payload.dart';
import 'package:baraka_pos/shared/shared.dart';

final class LoginRequest extends RemoteRequest<LoginPayload> {
  final String id;
  final String number;
  final String password;
  LoginRequest.fromPayload(super.payload)
      : id = payload.code,
        number = payload.number,
        password = payload.password,
        super.fromPayload();

  @override
  Json data() => {
        "code": id,
        "phone": number,
        "password": password,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
