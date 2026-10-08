import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/shared.dart';

final class LoginDto extends JsonDto<LoginModel> {
  final Json json;

  LoginDto.fromJson(this.json) : super.fromJson(json);

  String get access => json.text("access");

  String get refresh => json.text("refresh");

  UserDto get user => UserDto.fromJson(json.object("user"));

  @override
  LoginModel model() {
    return LoginModel(
      access: access,
      refresh: refresh,
      user: user.model(),
    );
  }
}
