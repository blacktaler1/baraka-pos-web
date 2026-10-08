part of 'update_category_bloc.dart';

sealed class UpdateCategoryState extends Equatable {
  const UpdateCategoryState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(CategoryModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      UpdateCategoryInitial() => initial(),
      UpdateCategoryPrepare() => inPrepare(),
      UpdateCategorySuccess(:final model) => success(model),
      UpdateCategoryFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(CategoryModel model)? success,
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
    T Function(CategoryModel model)? success,
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

final class UpdateCategoryInitial extends UpdateCategoryState {}

final class UpdateCategoryPrepare extends UpdateCategoryState {}

final class UpdateCategorySuccess extends UpdateCategoryState {
  final CategoryModel model;

  const UpdateCategorySuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class UpdateCategoryFailure extends UpdateCategoryState {
  final BaseException error;

  const UpdateCategoryFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
