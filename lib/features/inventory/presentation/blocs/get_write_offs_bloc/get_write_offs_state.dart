part of 'get_write_offs_bloc.dart';

sealed class GetWriteOffsState extends Equatable {
  const GetWriteOffsState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GetWriteOffsModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetWriteOffsInitial() => initial(),
      GetWriteOffsPrepare() => inPrepare(),
      GetWriteOffsSuccess(:final model) => success(model),
      GetWriteOffsFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GetWriteOffsModel model)? success,
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
    T Function(GetWriteOffsModel model)? success,
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

final class GetWriteOffsInitial extends GetWriteOffsState {}

final class GetWriteOffsPrepare extends GetWriteOffsState {}

final class GetWriteOffsSuccess extends GetWriteOffsState {
  final GetWriteOffsModel model;

  const GetWriteOffsSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetWriteOffsFailure extends GetWriteOffsState {
  final BaseException error;

  const GetWriteOffsFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
