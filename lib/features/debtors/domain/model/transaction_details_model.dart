import '../../../../shared/shared.dart';

final class TransactionDetailsModel extends Model {
  final String transactionId;
  final String created;
  final String totalSum;
  final String paymentMethod;

  const TransactionDetailsModel({
    required this.transactionId,
    required this.created,
    required this.totalSum,
    required this.paymentMethod,
  });

  @override
  List<String> get props => [
        "transactionId: $transactionId",
        "created: $created",
        "totalSum: $totalSum",
        "debt: $paymentMethod",
      ];
}
