part of 'loan_debt_bloc.dart';

sealed class LoanDebtState extends Equatable {
  const LoanDebtState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllLoanModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      LoanDebtInitial() => initial(),
      LoanDebtPrepare() => inPrepare(),
      LoanDebtSuccess(:final model) => success(model),
      LoanDebtFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(AllLoanModel model)? success,
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
    T Function(AllLoanModel model)? success,
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

final class LoanDebtInitial extends LoanDebtState {}

final class LoanDebtPrepare extends LoanDebtState {}

final class LoanDebtSuccess extends LoanDebtState {
  final AllLoanModel model;

  const LoanDebtSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class LoanDebtFailure extends LoanDebtState {
  final BaseException error;

  const LoanDebtFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
