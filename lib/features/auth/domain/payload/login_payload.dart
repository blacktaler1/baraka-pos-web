import 'package:baraka_pos/shared/shared.dart';

final class LoginPayload extends Payload {
  final String code;
  final String number;
  final String password;

  const LoginPayload({
    required this.code,
    required this.number,
    required this.password,
  });

  @override
  List<Object> get props => [
        "code: $code",
        "phone: $number",
        "password: $password",
      ];
}
