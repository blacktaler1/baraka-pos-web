import 'package:baraka_pos/shared/domain/domain.dart';

final class CreateDevicePayload extends Payload {
  final String name;
  final String deviceId;

  const CreateDevicePayload({
    required this.name,
    required this.deviceId,
  });

  @override
  List<Object> get props => [
        "name: $name",
        "deviceId: $deviceId",
      ];
}
