part of 'get_refund_bloc.dart';

sealed class GetRefundState extends Equatable {
  const GetRefundState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllRefundsModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetRefundInitial() => initial(),
      GetRefundPrepare() => inPrepare(),
      GetRefundSuccess(:final model) => success(model),
      GetRefundFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(AllRefundsModel model)? success,
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
    T Function(AllRefundsModel model)? success,
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

final class GetRefundInitial extends GetRefundState {}

final class GetRefundPrepare extends GetRefundState {}

final class GetRefundSuccess extends GetRefundState {
  final AllRefundsModel model;

  const GetRefundSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetRefundFailure extends GetRefundState {
  final BaseException error;

  const GetRefundFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
