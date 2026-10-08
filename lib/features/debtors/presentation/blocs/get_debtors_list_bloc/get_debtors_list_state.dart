part of 'get_debtors_list_bloc.dart';

sealed class GetDebtorsListState extends Equatable {
  const GetDebtorsListState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(DebtorsListModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetDebtorsListInitial() => initial(),
      GetDebtorsListPrepare() => inPrepare(),
      GetDebtorsListSuccess(:final model) => success(model),
      GetDebtorsListFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(DebtorsListModel model)? success,
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
    T Function(DebtorsListModel model)? success,
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

final class GetDebtorsListInitial extends GetDebtorsListState {}

final class GetDebtorsListPrepare extends GetDebtorsListState {}

final class GetDebtorsListSuccess extends GetDebtorsListState {
  final DebtorsListModel model;

  const GetDebtorsListSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetDebtorsListFailure extends GetDebtorsListState {
  final BaseException error;

  const GetDebtorsListFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
