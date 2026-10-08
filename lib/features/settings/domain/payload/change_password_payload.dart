import 'package:baraka_pos/shared/shared.dart';

final class ChangePasswordPayload extends Payload {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordPayload({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [
        "oldPassword: $oldPassword",
        "newPassword: $newPassword",
      ];
}
