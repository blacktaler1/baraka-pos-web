import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class CreateDeviceRequest extends RemoteRequest<CreateDevicePayload> {
  final String name;
  final String deviceId;
  CreateDeviceRequest.fromPayload(super.payload)
      : deviceId = payload.deviceId,
        name = payload.name,
        super.fromPayload();

  @override
  Json data() => {
        "name": name,
        "device_id": deviceId,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
