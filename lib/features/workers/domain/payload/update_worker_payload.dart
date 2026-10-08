import 'package:baraka_pos/shared/domain/domain.dart';

import '../model/worker_permissions.dart';

final class UpdateWorkerPayload extends Payload {
  final int id;

  final String phone;
  final String name;
  final String password;
  final List image;
  final WorkerPermissions? permissions;

  const UpdateWorkerPayload({
    required this.id,
    required this.phone,
    required this.name,
    required this.password,
    required this.image,
    this.permissions,
  });

  @override
  List<Object> get props => [
        "id: $id",
        "phone: $phone",
        "name: $name",
        "password: $password",
        "image: $image",
        "permissions: $permissions",
      ];
}
