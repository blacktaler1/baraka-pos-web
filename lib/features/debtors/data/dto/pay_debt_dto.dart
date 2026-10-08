import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:baraka_pos/shared/shared.dart';

final class PayDebtDto extends JsonDto<PayDebtModel> {
  final Json json;

  PayDebtDto.fromJson(this.json) : super.fromJson(json);

  bool get success => json.flag("success");

  String get message => json.text("message");

  num get remainingDebt => json.number("remaining_debt");

  bool get isPaid => json.flag("is_paid");

  @override
  PayDebtModel model() {
    return PayDebtModel(
      success: success,
      message: message,
      remaingDebt: remainingDebt,
      isPaid: isPaid,
    );
  }
}
