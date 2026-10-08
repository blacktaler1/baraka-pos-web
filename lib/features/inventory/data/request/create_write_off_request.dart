import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/model/stock_line_input.dart';
import '../../domain/payload/create_write_off_payload.dart';

final class CreateWriteOffRequest extends RemoteRequest<CreateWriteOffPayload> {
  final String reason;
  final String note;
  final List<StockLineInput> items;

  CreateWriteOffRequest.fromPayload(super.payload)
      : reason = payload.reason,
        note = payload.note,
        items = payload.items,
        super.fromPayload();

  @override
  Json data() => {
        "reason": reason,
        "note": note,
        "items": items.map((e) => e.toJson()).toList(),
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
