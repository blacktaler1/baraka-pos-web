part of 'export_products_bloc.dart';

sealed class ExportProductsState extends Equatable {
  const ExportProductsState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(FileBytesModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      ExportProductsInitial() => initial(),
      ExportProductsPrepare() => inPrepare(),
      ExportProductsSuccess(:final model) => success(model),
      ExportProductsFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(FileBytesModel model)? success,
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
    T Function(FileBytesModel model)? success,
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

final class ExportProductsInitial extends ExportProductsState {}

final class ExportProductsPrepare extends ExportProductsState {}

final class ExportProductsSuccess extends ExportProductsState {
  final FileBytesModel model;

  const ExportProductsSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class ExportProductsFailure extends ExportProductsState {
  final BaseException error;

  const ExportProductsFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
