part of 'delete_product_bloc.dart';

sealed class DeleteProductState extends Equatable {
  const DeleteProductState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(NoContentModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      DeleteProductInitial() => initial(),
      DeleteProductPrepare() => inPrepare(),
      DeleteProductSuccess(:final model) => success(model),
      DeleteProductFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(NoContentModel model)? success,
    T Function(BaseException error)? failure,
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
    T Function(NoContentModel model)? success,
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

final class DeleteProductPrepare extends DeleteProductState {}

final class DeleteProductInitial extends DeleteProductState {}

final class DeleteProductSuccess extends DeleteProductState {
  final NoContentModel model;

  const DeleteProductSuccess({required this.model});
}

final class DeleteProductFailure extends DeleteProductState {
  final BaseException error;

  const DeleteProductFailure({required this.error});

  @override
  List<Object> get props => ["error: $error "];
}
