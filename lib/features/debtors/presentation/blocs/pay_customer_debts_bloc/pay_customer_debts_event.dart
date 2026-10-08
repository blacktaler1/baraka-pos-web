part of 'pay_customer_debts_bloc.dart';

sealed class PayCustomerDebtsEvent extends Equatable {
  const PayCustomerDebtsEvent();

  @override
  List<Object> get props => [];
}

final class PayCustomerDebtsStarted extends PayCustomerDebtsEvent {
  final int customerId;
  final String amount;

  const PayCustomerDebtsStarted({
    required this.customerId,
    required this.amount,
  });

  @override
  List<Object> get props => [
        "customerId: $customerId",
        "amount: $amount",
      ];
}
