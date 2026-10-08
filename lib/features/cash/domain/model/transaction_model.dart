import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class TransactionModel extends Model {
  final int id;
  final String transactionId;
  final String paymentMethod;
  final String totalSum;
  final String discount;
  final String totalQuantity;
  final String profit;
  final TransactionItemCollection items;
  final CashierModel cashier;
  final String created;
  final String modified;

  const TransactionModel({
    required this.id,
    required this.transactionId,
    required this.paymentMethod,
    required this.totalSum,
    this.discount = "0",
    required this.totalQuantity,
    required this.profit,
    required this.items,
    required this.cashier,
    required this.created,
    required this.modified,
  });

  @override
  List<String> get props => [
        "id: $id",
        "transaction_id: $transactionId",
        "payment_method: $paymentMethod",
        "total_sum: $totalSum",
        "discount: $discount",
        "total_quantity: $totalQuantity",
        "profit: $profit",
        "items: $items",
        "cashier: $cashier",
        "created: $created",
        "modified: $modified",
      ];
}
