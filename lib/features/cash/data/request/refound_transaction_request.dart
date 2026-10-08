import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class RefundTransactionRequest
    extends RemoteRequest<RefoundTransactionPayload> {
  final int transactionId;
  final String description;
  final CreateItemCollection items;

  RefundTransactionRequest.fromPayload(super.payload)
      : transactionId = payload.transactionId,
        description = payload.description,
        items = payload.items,
        super.fromPayload();

  @override
  Json data() => {
        "description": description,
        "items": items.models.map((e) => e.toJson()).toList(),
      };

  @override
  Map<String, String> path() => {
        "pk": transactionId.toString(),
      };

  @override
  Map<String, String> query() => {};
}
