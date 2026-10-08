part of 'export_debtors_bloc.dart';

sealed class ExportDebtorsState extends Equatable {
  const ExportDebtorsState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(FileBytesModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      ExportDebtorsInitial() => initial(),
      ExportDebtorsPrepare() => inPrepare(),
      ExportDebtorsSuccess(:final model) => success(model),
      ExportDebtorsFailure(:final error) => failure(error),
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

final class ExportDebtorsInitial extends ExportDebtorsState {}

final class ExportDebtorsPrepare extends ExportDebtorsState {}

final class ExportDebtorsSuccess extends ExportDebtorsState {
  final FileBytesModel model;

  const ExportDebtorsSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class ExportDebtorsFailure extends ExportDebtorsState {
  final BaseException error;

  const ExportDebtorsFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
