part of 'delete_expense_bloc.dart';

sealed class DeleteExpenseEvent extends Equatable {
  const DeleteExpenseEvent();

  @override
  List<Object> get props => [];
}

final class DeleteExpenseStarted extends DeleteExpenseEvent {
  final int id;

  const DeleteExpenseStarted({required this.id});

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
