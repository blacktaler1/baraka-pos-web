import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:baraka_pos/shared/shared.dart';

final class ByCustomerItemDto extends JsonDto<ByCustomerItemModel> {
  final Json json;

  ByCustomerItemDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get paid => json.text("paid", fallback: "0");

  String get debt => json.text("debt", fallback: "0");

  bool get isPaid => json.flag("is_paid");

  String get deadline => json.text("deadline");

  String get created => json.text("created");

  TransactionDetailsDto get transactionDetails =>
      TransactionDetailsDto.fromJson(json.object("transaction_details"));

  ItemCollectionDto get items =>
      ItemCollectionDto.fromList(json.items("items"));

  @override
  ByCustomerItemModel model() {
    return ByCustomerItemModel(
      id: id,
      paid: paid,
      debt: debt,
      isPaid: isPaid,
      deadline: deadline,
      created: created,
      details: transactionDetails.model(),
      items: items.collection(),
    );
  }
}
