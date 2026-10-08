part of 'update_expense_bloc.dart';

sealed class UpdateExpenseState extends Equatable {
  const UpdateExpenseState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(ExpenseModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      UpdateExpenseInitial() => initial(),
      UpdateExpensePrepare() => inPrepare(),
      UpdateExpenseSuccess(:final model) => success(model),
      UpdateExpenseFailure(:final error) => failure(error),
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

final class UpdateExpenseInitial extends UpdateExpenseState {}

final class UpdateExpensePrepare extends UpdateExpenseState {}

final class UpdateExpenseSuccess extends UpdateExpenseState {
  final ExpenseModel model;

  const UpdateExpenseSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class UpdateExpenseFailure extends UpdateExpenseState {
  final BaseException error;

  const UpdateExpenseFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
