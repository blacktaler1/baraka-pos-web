import 'package:baraka_pos/shared/aplication/types/json.dart';

import '../../../../shared/data/data.dart';
import '../../domain/payload/stock_update_payload.dart';

final class StockUpdateRequest extends RemoteRequest<StockUpdatePayload> {
  final String action;
  final double amount;
  final int pk;

  StockUpdateRequest.fromPayload(super.payload)
      : action = payload.action,
        amount = payload.amount,
        pk = payload.pk,
        super.fromPayload();

  @override
  Json data() => {
        "action": action,
        "amount": amount,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
