part of 'get_turnover_bloc.dart';

sealed class GetTurnoverState extends Equatable {
  const GetTurnoverState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(TurnoverCardModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetTurnoverInitial() => initial(),
      GetTurnoverPrepare() => inPrepare(),
      GetTurnoverSuccess(:final model) => success(model),
      GetTurnoverFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(TurnoverCardModel model)? success,
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
    T Function(TurnoverCardModel model)? success,
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

final class GetTurnoverInitial extends GetTurnoverState {}

final class GetTurnoverPrepare extends GetTurnoverState {}

final class GetTurnoverSuccess extends GetTurnoverState {
  final TurnoverCardModel model;

  const GetTurnoverSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetTurnoverFailure extends GetTurnoverState {
  final BaseException error;

  const GetTurnoverFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
