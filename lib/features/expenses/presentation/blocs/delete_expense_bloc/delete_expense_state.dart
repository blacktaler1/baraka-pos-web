part of 'delete_expense_bloc.dart';

sealed class DeleteExpenseState extends Equatable {
  const DeleteExpenseState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(NoContentModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      DeleteExpenseInitial() => initial(),
      DeleteExpensePrepare() => inPrepare(),
      DeleteExpenseSuccess(:final model) => success(model),
      DeleteExpenseFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(NoContentModel model)? success,
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
    T Function(NoContentModel model)? success,
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

final class DeleteExpenseInitial extends DeleteExpenseState {}

final class DeleteExpensePrepare extends DeleteExpenseState {}

final class DeleteExpenseSuccess extends DeleteExpenseState {
  final NoContentModel model;

  const DeleteExpenseSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class DeleteExpenseFailure extends DeleteExpenseState {
  final BaseException error;

  const DeleteExpenseFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
