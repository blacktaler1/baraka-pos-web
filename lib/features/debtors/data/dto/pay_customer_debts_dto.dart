import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:baraka_pos/shared/shared.dart';

final class PayCustomerDebtsDto extends JsonDto<PayCustomerDebtsModel> {
  final Json json;

  PayCustomerDebtsDto.fromJson(this.json) : super.fromJson(json);

  num get paidAmount => json.number("paid_amount");

  int get recordsAffected => json.integer("records_affected");

  num get remainingDebt => json.number("remaining_debt");

  @override
  PayCustomerDebtsModel model() {
    return PayCustomerDebtsModel(
      paidAmount: paidAmount,
      recordsAffected: recordsAffected,
      remainingDebt: remainingDebt,
    );
  }
}
