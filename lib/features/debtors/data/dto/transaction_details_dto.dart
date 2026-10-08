import 'package:baraka_pos/features/debtors/domain/model/transaction_details_model.dart';
import 'package:baraka_pos/shared/shared.dart';

final class TransactionDetailsDto extends JsonDto<TransactionDetailsModel> {
  final Json json;

  TransactionDetailsDto.fromJson(this.json) : super.fromJson(json);

  String get transactionId => json.text("transaction_id");

  String get created => json.text("created");

  String get totalSum => json.text("total_sum", fallback: "0");

  String get paymentMethod => json.text("payment_method");

  @override
  TransactionDetailsModel model() {
    return TransactionDetailsModel(
      transactionId: transactionId,
      created: created,
      totalSum: totalSum,
      paymentMethod: paymentMethod,
    );
  }
}
