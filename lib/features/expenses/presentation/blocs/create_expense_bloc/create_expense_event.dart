part of 'create_expense_bloc.dart';

sealed class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

final class CreateExpenseStarted extends CreateExpenseEvent {
  final String title;
  final int amount;

  /// Yaratishda: null — kategoriyasiz. Tahrirda: null — o'zgarmaydi, 0 — olib tashlash
  final int? categoryId;

  const CreateExpenseStarted({
    required this.title,
    required this.amount,
    this.categoryId,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "amount: $amount",
        "category: $categoryId",
      ];
}
