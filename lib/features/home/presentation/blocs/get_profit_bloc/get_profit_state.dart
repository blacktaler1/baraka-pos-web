part of 'get_profit_bloc.dart';

sealed class GetProfitState extends Equatable {
  const GetProfitState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(TurnoverCardModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetProfitInitial() => initial(),
      GetProfitPrepare() => inPrepare(),
      GetProfitSuccess(:final model) => success(model),
      GetProfitFailure(:final error) => failure(error),
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

final class GetProfitInitial extends GetProfitState {}

final class GetProfitPrepare extends GetProfitState {}

final class GetProfitSuccess extends GetProfitState {
  final TurnoverCardModel model;

  const GetProfitSuccess({required this.model});

  @override
  List<Object> get props => ["model: $model"];
}

final class GetProfitFailure extends GetProfitState {
  final BaseException error;

  const GetProfitFailure({required this.error});

  @override
  List<Object> get props => ["error: $error"];
}
