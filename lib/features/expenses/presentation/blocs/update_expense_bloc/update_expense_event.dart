part of 'update_expense_bloc.dart';

sealed class UpdateExpenseEvent extends Equatable {
  const UpdateExpenseEvent();

  @override
  List<Object> get props => [];
}

final class UpdateExpenseStarted extends UpdateExpenseEvent {
  final String title;
  final int amount;
  final int id;

  const UpdateExpenseStarted({
    required this.id,
    required this.title,
    required this.amount,
  });

  @override
  List<Object> get props => [
        "id: $id",
        "title: $title",
        "amount: $amount",
      ];
}
