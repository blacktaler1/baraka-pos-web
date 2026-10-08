part of 'cash_product_bloc.dart';

sealed class CashProductState extends Equatable {
  const CashProductState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllCashProductModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CashProductInitial() => initial(),
      CashProductPrepare() => inPrepare(),
      CashProductSuccess(:final model) => success(model),
      CashProductFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(AllCashProductModel model)? success,
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
    T Function(AllCashProductModel model)? success,
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

final class CashProductInitial extends CashProductState {}

final class CashProductPrepare extends CashProductState {}

final class CashProductSuccess extends CashProductState {
  final AllCashProductModel model;

  const CashProductSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CashProductFailure extends CashProductState {
  final BaseException error;

  const CashProductFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
