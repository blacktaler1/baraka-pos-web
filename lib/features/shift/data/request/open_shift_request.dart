import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/open_shift_payload.dart';

final class OpenShiftRequest extends RemoteRequest<OpenShiftPayload> {
  final int openingCash;

  OpenShiftRequest.fromPayload(super.payload)
      : openingCash = payload.openingCash,
        super.fromPayload();

  @override
  Json data() => {
        "opening_cash": openingCash,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
