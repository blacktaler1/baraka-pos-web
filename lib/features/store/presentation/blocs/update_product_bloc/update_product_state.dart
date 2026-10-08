part of 'update_product_bloc.dart';

sealed class UpdateProductState extends Equatable {
  const UpdateProductState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(ProductModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      UpdateProductInitial() => initial(),
      UpdateProductPrepare() => inPrepare(),
      UpdateProductSuccess(:final model) => success(model),
      UpdateProductFailure(:final error) => failure(error),
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

final class UpdateProductInitial extends UpdateProductState {}

final class UpdateProductPrepare extends UpdateProductState {}

final class UpdateProductFailure extends UpdateProductState {
  final BaseException error;

  const UpdateProductFailure({required this.error});

  @override
  List<Object> get props => ["error"];
}

final class UpdateProductSuccess extends UpdateProductState {
  final ProductModel model;

  const UpdateProductSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}
