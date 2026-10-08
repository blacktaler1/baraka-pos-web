import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class GetRefundDto extends JsonDto<GetRefundModel> {
  final Json json;

  const GetRefundDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get transactionId => json.text("transaction_id");

  String get totalPrice => json.text("total_price", fallback: "0");

  CashierModel get cashier =>
      CashierDto.fromJson(json.object('cashier')).model();

  String get totalNum => json.text("total_num", fallback: "0");

  String get description => json.text("description");

  TransactionItemCollection get items =>
      TransactionItemCollectionDto.fromList(json.items('items')).collection();

  String get created => json["created"] ?? "";

  @override
  GetRefundModel model() {
    return GetRefundModel(
      id: id,
      transactionId: transactionId,
      totalPrice: totalPrice,
      cashier: cashier,
      totalNum: totalNum,
      description: description,
      items: items,
      created: created,
    );
  }
}
