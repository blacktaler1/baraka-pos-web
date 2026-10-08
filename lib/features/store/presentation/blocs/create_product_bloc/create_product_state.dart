part of 'create_product_bloc.dart';

sealed class CreateProductState extends Equatable {
  const CreateProductState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(ProductModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CreateProductInitial() => initial(),
      CreateProductPrepare() => inPrepare(),
      CreateProductSuccess(:final model) => success(model),
      CreateProductFailure(:final error) => failure(error),
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

final class CreateProductInitial extends CreateProductState {}

final class CreateProductPrepare extends CreateProductState {}

final class CreateProductSuccess extends CreateProductState {
  final ProductModel model;

  const CreateProductSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CreateProductFailure extends CreateProductState {
  final BaseException error;

  const CreateProductFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
