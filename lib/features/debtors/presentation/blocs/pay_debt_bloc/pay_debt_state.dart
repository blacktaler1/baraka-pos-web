part of 'pay_debt_bloc.dart';

sealed class PayDebtState extends Equatable {
  const PayDebtState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(PayDebtModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      PayDebtInitial() => initial(),
      PayDebtPrepare() => inPrepare(),
      PayDebtFailure(:final error) => failure(error),
      PayDebtSuccess(:final model) => success(model),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(PayDebtModel model)? success,
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
    T Function(PayDebtModel model)? success,
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

final class PayDebtInitial extends PayDebtState {}

final class PayDebtPrepare extends PayDebtState {}

final class PayDebtFailure extends PayDebtState {
  final BaseException error;

  const PayDebtFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}

final class PayDebtSuccess extends PayDebtState {
  final PayDebtModel model;

  const PayDebtSuccess({required this.model});

  @override
  List<Object> get props => [
        "$model: model",
      ];
}
