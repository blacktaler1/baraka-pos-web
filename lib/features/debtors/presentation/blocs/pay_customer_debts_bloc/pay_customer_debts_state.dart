part of 'pay_customer_debts_bloc.dart';

sealed class PayCustomerDebtsState extends Equatable {
  const PayCustomerDebtsState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(PayCustomerDebtsModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      PayCustomerDebtsInitial() => initial(),
      PayCustomerDebtsPrepare() => inPrepare(),
      PayCustomerDebtsSuccess(:final model) => success(model),
      PayCustomerDebtsFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(PayCustomerDebtsModel model)? success,
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
    T Function()? inPrepare,
    T Function(PayCustomerDebtsModel model)? success,
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

final class PayCustomerDebtsInitial extends PayCustomerDebtsState {}

final class PayCustomerDebtsPrepare extends PayCustomerDebtsState {}

final class PayCustomerDebtsSuccess extends PayCustomerDebtsState {
  final PayCustomerDebtsModel model;

  const PayCustomerDebtsSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class PayCustomerDebtsFailure extends PayCustomerDebtsState {
  final BaseException error;

  const PayCustomerDebtsFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
