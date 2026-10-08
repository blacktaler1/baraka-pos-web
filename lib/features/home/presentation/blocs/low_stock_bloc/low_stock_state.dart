part of 'low_stock_bloc.dart';

sealed class LowStockState extends Equatable {
  const LowStockState();
  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllProductModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      LowStockInitial() => initial(),
      LowStockPrepare() => inPrepare(),
      LowStockSuccess(:final model) => success(model),
      LowStockFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(AllProductModel model)? success,
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
    T Function(AllProductModel model)? success,
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

final class LowStockInitial extends LowStockState {}

final class LowStockPrepare extends LowStockState {}

final class LowStockFailure extends LowStockState {
  final BaseException error;

  const LowStockFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}

final class LowStockSuccess extends LowStockState {
  final AllProductModel model;

  const LowStockSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}
