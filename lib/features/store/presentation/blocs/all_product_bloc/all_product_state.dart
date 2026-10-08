part of 'all_product_bloc.dart';

sealed class AllProductState extends Equatable {
  const AllProductState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllProductModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      AllProductInitial() => initial(),
      AllProductPrepare() => inPrepare(),
      AllProductSuccess(:final model) => success(model),
      AllProductFailure(:final error) => failure(error),
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

final class AllProductInitial extends AllProductState {}

final class AllProductPrepare extends AllProductState {}

final class AllProductFailure extends AllProductState {
  final BaseException error;

  const AllProductFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}

final class AllProductSuccess extends AllProductState {
  final AllProductModel model;

  const AllProductSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}
