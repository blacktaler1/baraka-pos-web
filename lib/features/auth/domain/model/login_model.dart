import 'package:baraka_pos/features/auth/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

final class LoginModel extends Model {
  final String access;
  final String refresh;
  final UserModel user;

  const LoginModel({
    required this.access,
    required this.refresh,
    required this.user,
  });

  @override
  List<String> get props => [
        "access: $access",
        "refresh: $refresh",
        "user: $user",
      ];
}
