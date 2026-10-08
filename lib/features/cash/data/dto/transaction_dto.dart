import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class TransactionDto extends JsonDto<TransactionModel> {
  final Json json;

  const TransactionDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer('id');

  String get transactionId => json.text('transaction_id');

  String get paymentMethod => json.text('payment_method');

  String get totalSum => json.text('total_sum', fallback: "0");

  String get discount => json.text('discount', fallback: "0");

  String get totalQuantity => json.number('total_quantity').toString();

  String get profit => json.text('profit', fallback: "0");

  TransactionItemCollection get items =>
      TransactionItemCollectionDto.fromList(json.items('items')).collection();

  CashierModel get cashier =>
      CashierDto.fromJson(json.object('cashier')).model();

  String get created => json.text('created');

  String get modified => json.text('modified');

  @override
  TransactionModel model() {
    return TransactionModel(
      id: id,
      transactionId: transactionId,
      paymentMethod: paymentMethod,
      totalSum: totalSum,
      discount: discount,
      totalQuantity: totalQuantity,
      items: items,
      profit: profit,
      cashier: cashier,
      created: created,
      modified: modified,
    );
  }
}
