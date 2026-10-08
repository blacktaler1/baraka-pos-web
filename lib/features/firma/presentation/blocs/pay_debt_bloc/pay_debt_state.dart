part of 'pay_debt_bloc.dart';

sealed class LoanFirmaState extends Equatable {
  const LoanFirmaState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(LoanFirmaModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      LoanFirmaInitial() => initial(),
      LoanFirmaPrepare() => inPrepare(),
      LoanFirmaSuccess(:final model) => success(model),
      LoanFirmaFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(LoanFirmaModel model)? success,
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
    T Function(LoanFirmaModel model)? success,
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

final class LoanFirmaInitial extends LoanFirmaState {}

final class LoanFirmaPrepare extends LoanFirmaState {}

final class LoanFirmaSuccess extends LoanFirmaState {
  final LoanFirmaModel model;

  const LoanFirmaSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class LoanFirmaFailure extends LoanFirmaState {
  final BaseException error;

  const LoanFirmaFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
