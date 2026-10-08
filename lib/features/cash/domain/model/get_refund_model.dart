import 'package:baraka_pos/features/cash/domain/model/transaction_item_collection.dart';

import '../../../../shared/domain/domain.dart';
import 'cashier_model.dart';

final class GetRefundModel extends Model {
  final int id;
  final String transactionId;
  final String totalPrice;
  final CashierModel cashier;
  final String totalNum;
  final String description;
  final TransactionItemCollection items;
  final String created;

  const GetRefundModel({
    required this.id,
    required this.transactionId,
    required this.totalPrice,
    required this.cashier,
    required this.totalNum,
    required this.description,
    required this.items,
    required this.created,
  });

  @override
  List<String> get props => [
        "id: $id",
        "transaction_id: $transactionId",
        "total_price: $totalPrice",
        "cashier: $cashier"
            "total_num: $totalNum",
        "description: $description",
        "items: $items",
        "created: $created"
      ];
}
