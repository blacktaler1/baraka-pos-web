part of 'pay_debt_bloc.dart';

sealed class LoanFirmaEvent extends Equatable {
  const LoanFirmaEvent();

  @override
  List<Object> get props => [];
}

final class LoanFirmaStarted extends LoanFirmaEvent {
  final int firmaId;
  final int debtId;
  final int amount;

  const LoanFirmaStarted({
    required this.firmaId,
    required this.debtId,
    required this.amount,
  });

  @override
  List<Object> get props => [
        "id:$firmaId",
        "pk: $debtId",
        "amount: $amount",
      ];
}
