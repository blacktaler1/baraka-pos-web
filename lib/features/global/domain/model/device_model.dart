import 'package:baraka_pos/shared/domain/domain.dart';

final class DeviceModel extends Model {
  final int id;
  final String createdAt;
  final String modified;
  final String name;
  final String deviceId;
  final String status;
  final String lastActive;
  final int user;

  const DeviceModel({
    required this.id,
    required this.createdAt,
    required this.modified,
    required this.name,
    required this.deviceId,
    required this.status,
    required this.lastActive,
    required this.user,
  });

  @override
  List<String> get props => [
        "id: $id",
        "createdAt: $createdAt",
        "modified: $modified",
        "name: $name",
        "deviceId: $deviceId",
        "status: $status",
        "lastActive: $lastActive",
        "user: $user",
      ];
}
