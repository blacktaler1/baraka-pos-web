import '../../../../shared/domain/domain.dart';

final class PayDebtModel extends Model {
  final bool success;
  final String message;
  final num remaingDebt;
  final bool isPaid;

  const PayDebtModel({
    required this.success,
    required this.message,
    required this.remaingDebt,
    required this.isPaid,
  });

  @override
  List<String> get props => [
        "success: $success",
        "message: $message",
        "remaingDebt: $remaingDebt",
        "isPaid: $isPaid",
      ];
}
