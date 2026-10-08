import 'package:baraka_pos/features/workers/domain/model/worker_permissions.dart';
import 'package:baraka_pos/features/workers/domain/payload/create_worker_payload.dart';
import 'package:baraka_pos/shared/shared.dart';

final class CreateWorkerRequest extends RemoteRequest<CreateWorkerPayload> {
  final String name;
  final String phone;
  final String role;
  final String password;
  final List image;
  final WorkerPermissions permissions;

  CreateWorkerRequest.fromPayload(super.payload)
      : name = payload.name,
        phone = payload.phone,
        password = payload.password,
        role = payload.role,
        image = payload.image,
        permissions = payload.permissions,
        super.fromPayload();

  @override
  Json data() => {
        "name": name,
        "phone": phone,
        "role": role,
        "password": password,
        if (image.isNotEmpty && !(image.length == 1 && image.first == 000))
          "image_ids": image,
        ...permissions.toJson(),
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
// {
//     "name": "Alakakachi",       // Name of the user
//     "phone": "+998931245676",   // Phone Number of the user
//     "role": "manager",          // manager | cashier , role for the user
//     "password": "124543",       // Password for user
//     "image": []                 // List of image IDs
// }
