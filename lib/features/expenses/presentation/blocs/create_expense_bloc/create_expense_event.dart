part of 'create_expense_bloc.dart';

sealed class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

final class CreateExpenseStarted extends CreateExpenseEvent {
  final String title;
  final int amount;

  const CreateExpenseStarted({
    required this.title,
    required this.amount,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "amount: $amount",
      ];
}
