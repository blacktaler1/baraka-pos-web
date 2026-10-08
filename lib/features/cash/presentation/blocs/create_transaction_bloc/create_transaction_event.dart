part of 'create_transaction_bloc.dart';

sealed class CreateTransactionEvent extends Equatable {
  const CreateTransactionEvent();

  @override
  List<Object> get props => [];
}

final class CreateTransactionStarted extends CreateTransactionEvent {
  final String paymentMethod;
  final int customer;
  final int paidAmount;
  final String deadline;
  final String description;
  final int discount;
  final CreateItemCollection items;

  const CreateTransactionStarted({
    required this.paymentMethod,
    required this.customer,
    required this.paidAmount,
    required this.deadline,
    required this.description,
    this.discount = 0,
    required this.items,
  });

  @override
  List<Object> get props => [
        "payment_method: $paymentMethod",
        "customer: $customer",
        "paid_amount: $paidAmount",
        "deadline: $deadline",
        "description: $description",
        "discount: $discount",
        "items: $items",
      ];
}
