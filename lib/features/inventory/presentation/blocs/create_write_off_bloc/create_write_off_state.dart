part of 'create_write_off_bloc.dart';

sealed class CreateWriteOffState extends Equatable {
  const CreateWriteOffState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(WriteOffCollection model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CreateWriteOffInitial() => initial(),
      CreateWriteOffPrepare() => inPrepare(),
      CreateWriteOffSuccess(:final model) => success(model),
      CreateWriteOffFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(WriteOffCollection model)? success,
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
    T Function(WriteOffCollection model)? success,
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

final class CreateWriteOffInitial extends CreateWriteOffState {}

final class CreateWriteOffPrepare extends CreateWriteOffState {}

final class CreateWriteOffSuccess extends CreateWriteOffState {
  final WriteOffCollection model;

  const CreateWriteOffSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CreateWriteOffFailure extends CreateWriteOffState {
  final BaseException error;

  const CreateWriteOffFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
