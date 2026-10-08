part of 'import_products_bloc.dart';

sealed class ImportProductsState extends Equatable {
  const ImportProductsState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(ImportResultModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      ImportProductsInitial() => initial(),
      ImportProductsPrepare() => inPrepare(),
      ImportProductsSuccess(:final model) => success(model),
      ImportProductsFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(ImportResultModel model)? success,
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
    T Function()? inPrepare,
    T Function(ImportResultModel model)? success,
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

final class ImportProductsInitial extends ImportProductsState {}

final class ImportProductsPrepare extends ImportProductsState {}

final class ImportProductsSuccess extends ImportProductsState {
  final ImportResultModel model;

  const ImportProductsSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class ImportProductsFailure extends ImportProductsState {
  final BaseException error;

  const ImportProductsFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
