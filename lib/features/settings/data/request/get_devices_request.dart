import 'package:baraka_pos/features/settings/domain/payload/get_devices_payload.dart';
import 'package:baraka_pos/shared/shared.dart';

final class GetDevicesRequest extends RemoteRequest<GetDevicesPayload> {
  GetDevicesRequest.fromPayload(super.payload) : super.fromPayload();

  @override
  Json data() => {};
  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
