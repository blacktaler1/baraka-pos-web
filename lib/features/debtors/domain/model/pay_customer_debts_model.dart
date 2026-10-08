import 'package:baraka_pos/shared/shared.dart';

final class PayCustomerDebtsModel extends Model {
  final num paidAmount;
  final int recordsAffected;
  final num remainingDebt;

  const PayCustomerDebtsModel({
    required this.paidAmount,
    required this.recordsAffected,
    required this.remainingDebt,
  });

  @override
  List<String> get props => [
        "paid_amount: $paidAmount",
        "records_affected: $recordsAffected",
        "remaining_debt: $remainingDebt",
      ];
}
