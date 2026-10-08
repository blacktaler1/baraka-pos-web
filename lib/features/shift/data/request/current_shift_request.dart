import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/current_shift_payload.dart';

final class CurrentShiftRequest extends RemoteRequest<CurrentShiftPayload> {
  CurrentShiftRequest.fromPayload(super.payload) : super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
