import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

final class UpdateWorkerRequest extends RemoteRequest<UpdateWorkerPayload> {
  final int id;
  final String phone;
  final String name;
  final String password;
  final List<int> image; // endi list<int>
  final WorkerPermissions? permissions;

  UpdateWorkerRequest.fromPayload(super.payload)
      : phone = payload.phone,
        id = payload.id,
        name = payload.name,
        password = payload.password,
        image = List<int>.from(payload.image),
        permissions = payload.permissions,
        super.fromPayload();

  @override
  Json data() {
    return {
      if (phone.isNotEmpty) "phone": phone,
      if (name.isNotEmpty) "name": name,
      if (password.isNotEmpty) "password": password,
      if (image.isNotEmpty) "image_ids": image,
      ...?permissions?.toJson(),
    };
  }

  @override
  Map<String, String> path() => {
        "id": id.toString(),
      };

  @override
  Map<String, String> query() => {};
}
