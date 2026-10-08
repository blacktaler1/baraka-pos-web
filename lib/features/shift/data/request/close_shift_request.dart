import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/close_shift_payload.dart';

final class CloseShiftRequest extends RemoteRequest<CloseShiftPayload> {
  final int id;
  final int closingCash;
  final String note;

  CloseShiftRequest.fromPayload(super.payload)
      : id = payload.id,
        closingCash = payload.closingCash,
        note = payload.note,
        super.fromPayload();

  @override
  Json data() => {
        "closing_cash": closingCash,
        if (note.isNotEmpty) "note": note,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
