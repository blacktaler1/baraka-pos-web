part of 'delete_category_bloc.dart';

sealed class DeleteCategoryState extends Equatable {
  const DeleteCategoryState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(DeleteCategoryModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      DeleteCategoryInitial() => initial(),
      DeleteCategoryPrepare() => inPrepare(),
      DeleteCategorySuccess(:final model) => success(model),
      DeleteCategoryFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(DeleteCategoryModel model)? success,
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
    T Function(DeleteCategoryModel model)? success,
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

final class DeleteCategoryInitial extends DeleteCategoryState {}

final class DeleteCategoryPrepare extends DeleteCategoryState {}

final class DeleteCategorySuccess extends DeleteCategoryState {
  final DeleteCategoryModel model;

  const DeleteCategorySuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class DeleteCategoryFailure extends DeleteCategoryState {
  final BaseException error;

  const DeleteCategoryFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
