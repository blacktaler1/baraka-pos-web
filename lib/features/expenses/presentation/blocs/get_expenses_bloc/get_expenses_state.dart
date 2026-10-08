part of 'get_expenses_bloc.dart';

sealed class GetExpensesState extends Equatable {
  const GetExpensesState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GetExpensesModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetExpensesInitial() => initial(),
      GetExpensesPrepare() => inPrepare(),
      GetExpensesSuccess(:final model) => success(model),
      GetExpensesFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GetExpensesModel model)? success,
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
    T Function(GetExpensesModel model)? success,
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

final class GetExpensesInitial extends GetExpensesState {}

final class GetExpensesPrepare extends GetExpensesState {}

final class GetExpensesSuccess extends GetExpensesState {
  final GetExpensesModel model;

  const GetExpensesSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetExpensesFailure extends GetExpensesState {
  final BaseException error;

  const GetExpensesFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
