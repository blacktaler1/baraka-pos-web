import 'package:baraka_pos/features/global/domain/model/device_model.dart';

import '../../../../shared/shared.dart';

final class DeviceDto extends JsonDto<DeviceModel> {
  final Json json;

  DeviceDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");
  String get createdAt => json.text("created");
  String get modified => json.text("modified");
  String get name => json.text("name");
  String get deviceId => json.text("device_id");
  String get status => json.text("status");
  String get lastActive => json.text("last_active");
  int get user => json.integer("user");
  @override
  DeviceModel model() {
    return DeviceModel(
      id: id,
      createdAt: createdAt,
      modified: modified,
      name: name,
      deviceId: deviceId,
      status: status,
      lastActive: lastActive,
      user: user,
    );
  }
}
