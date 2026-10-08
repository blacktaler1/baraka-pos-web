part of 'stock_update_bloc.dart';

sealed class StockUpdateState extends Equatable {
  const StockUpdateState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(ProductModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      StockUpdateInitial() => initial(),
      StockUpdatePrepare() => inPrepare(),
      StockUpdateSuccess(:final model) => success(model),
      StockUpdateFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(ProductModel model)? success,
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
    T Function(ProductModel model)? success,
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

final class StockUpdateInitial extends StockUpdateState {}

final class StockUpdatePrepare extends StockUpdateState {}

final class StockUpdateFailure extends StockUpdateState {
  final BaseException error;

  const StockUpdateFailure({required this.error});

  @override
  List<Object> get props => ["error"];
}

final class StockUpdateSuccess extends StockUpdateState {
  final ProductModel model;

  const StockUpdateSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}
