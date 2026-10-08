part of 'pay_debt_bloc.dart';

final class PayDebtEvent extends Equatable {
  final int id;
  final num amount;

  const PayDebtEvent({required this.id, required this.amount});

  @override
  List<Object> get props => [
        "id: $id",
        "amount: $amount",
      ];
}
