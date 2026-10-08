import 'package:baraka_pos/shared/domain/domain.dart';

import '../model/worker_permissions.dart';

final class CreateWorkerPayload extends Payload {
  final String name;
  final String phone;
  final String role;
  final String password;
  final List image;
  final WorkerPermissions permissions;

  const CreateWorkerPayload({
    required this.name,
    required this.phone,
    required this.role,
    required this.password,
    required this.image,
    required this.permissions,
  });
  @override
  List<Object> get props => [
        "name: $name",
        "phone: $phone",
        "role: $role",
        "password: $password",
        "image: $image",
        "permissions: $permissions",
      ];
}
