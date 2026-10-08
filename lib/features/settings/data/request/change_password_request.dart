import 'package:baraka_pos/features/settings/domain/payload/payload.dart';
import 'package:baraka_pos/shared/shared.dart';

final class ChangePasswordRequest extends RemoteRequest<ChangePasswordPayload> {
  final String oldPassword;
  final String newPassword;
  ChangePasswordRequest.fromPayload(super.payload)
      : oldPassword = payload.oldPassword,
        newPassword = payload.newPassword,
        super.fromPayload();

  @override
  Json data() => {
        "old_password": oldPassword,
        "new_password": newPassword,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
