import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/model/stock_line_input.dart';
import '../../domain/payload/create_receipt_payload.dart';

final class CreateReceiptRequest extends RemoteRequest<CreateReceiptPayload> {
  final int firmaId;
  final int paidAmount;
  final String note;
  final List<StockLineInput> items;

  CreateReceiptRequest.fromPayload(super.payload)
      : firmaId = payload.firmaId,
        paidAmount = payload.paidAmount,
        note = payload.note,
        items = payload.items,
        super.fromPayload();

  @override
  Json data() => {
        if (firmaId != 0) "firma_id": firmaId,
        "paid_amount": paidAmount,
        "note": note,
        "items": items.map((e) => e.toJson()).toList(),
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
