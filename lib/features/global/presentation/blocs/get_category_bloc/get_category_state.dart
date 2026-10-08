part of 'get_category_bloc.dart';

sealed class GetCategoryState extends Equatable {
  const GetCategoryState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GetCategoryModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetCategoryInitial() => initial(),
      GetCategoryPrepare() => inPrepare(),
      GetCategorySuccess(:final model) => success(model),
      GetCategoryFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GetCategoryModel model)? success,
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
    T Function(GetCategoryModel model)? success,
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

final class GetCategoryInitial extends GetCategoryState {}

final class GetCategoryPrepare extends GetCategoryState {}

final class GetCategorySuccess extends GetCategoryState {
  final GetCategoryModel model;

  const GetCategorySuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetCategoryFailure extends GetCategoryState {
  final BaseException error;

  const GetCategoryFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
