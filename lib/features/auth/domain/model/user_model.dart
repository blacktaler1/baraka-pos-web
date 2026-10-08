import 'package:baraka_pos/features/workers/domain/model/worker_permissions.dart';
import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/shared.dart';

final class UserModel extends Model {
  final int id;
  final String name;
  final String role;
  final String code;
  final String phone;
  final String limit;
  final String dateJoined;
  final bool limitExceeded;
  final ImageCollection images;
  final WarehouseModel warehouse;
  final WorkerPermissions permissions;

  const UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.code,
    required this.phone,
    required this.limit,
    required this.dateJoined,
    required this.limitExceeded,
    required this.images,
    required this.warehouse,
    required this.permissions,
  });

  @override
  List<String> get props => [
        "id: $id",
        "name: $name",
        "role: $role",
        "code: $code",
        "phone: $phone",
        "limit: $limit",
        "dateJoined: $dateJoined",
        "limitExceeded: $limitExceeded",
        "images: $images",
        "warehouse: $warehouse",
        "permissions: $permissions",
      ];
}
