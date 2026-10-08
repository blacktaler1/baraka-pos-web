part of 'create_expense_bloc.dart';

sealed class CreateExpenseState extends Equatable {
  const CreateExpenseState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(ExpenseModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CreateExpenseInitial() => initial(),
      CreateExpensePrepare() => inPrepare(),
      CreateExpenseSuccess(:final model) => success(model),
      CreateExpenseFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(ExpenseModel model)? success,
    T Function(BaseException)? failure,
    required T Function() orElse,
  }) {
    return when(
      initial: initial ?? orElse,
      inPrepare: inPrepare ?? orElse,
      failure: failure ?? (_) => orElse(),
      success: success ?? (_) => orElse(),
    );
  }

  T? whenOrNull<T>({
    T Function()? idle,
    T Function()? inPrepare,
    T Function(ExpenseModel model)? success,
    T Function(BaseException error)? failure,
  }) {
    return maybeWhen(
      inPrepare: inPrepare,
      failure: failure,
      success: success,
      orElse: () => null,
    );
  }

  @override
  List<Object> get props => [];
}

final class CreateExpenseInitial extends CreateExpenseState {}

final class CreateExpensePrepare extends CreateExpenseState {}

final class CreateExpenseSuccess extends CreateExpenseState {
  final ExpenseModel model;

  const CreateExpenseSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CreateExpenseFailure extends CreateExpenseState {
  final BaseException error;

  const CreateExpenseFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
