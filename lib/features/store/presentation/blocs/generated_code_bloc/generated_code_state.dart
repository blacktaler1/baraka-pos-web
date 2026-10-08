part of 'generated_code_bloc.dart';

sealed class GeneratedCodeState extends Equatable {
  const GeneratedCodeState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GeneratedCodeModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GeneratedCodeInitial() => initial(),
      GeneratedCodePrepare() => inPrepare(),
      GeneratedCodeSuccess(:final model) => success(model),
      GeneratedCodeFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GeneratedCodeModel model)? success,
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
    T Function(GeneratedCodeModel model)? success,
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

final class GeneratedCodeInitial extends GeneratedCodeState {}

final class GeneratedCodePrepare extends GeneratedCodeState {}

final class GeneratedCodeFailure extends GeneratedCodeState {
  final BaseException error;

  const GeneratedCodeFailure({required this.error});
  @override
  List<Object> get props => [
        "error: $error",
      ];
}

final class GeneratedCodeSuccess extends GeneratedCodeState {
  final GeneratedCodeModel model;

  const GeneratedCodeSuccess({required this.model});
  @override
  List<Object> get props => [
        "model: $model",
      ];
}
