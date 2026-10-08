part of 'global_product_search_bloc.dart';

sealed class GlobalProductSearchState extends Equatable {
  const GlobalProductSearchState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GlobalProductSearchModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GlobalProductSearchInitial() => initial(),
      GlobalProductSearchPrepare() => inPrepare(),
      GlobalProductSearchSuccess(:final model) => success(model),
      GlobalProductSearchFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GlobalProductSearchModel model)? success,
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
    T Function(GlobalProductSearchModel model)? success,
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

final class GlobalProductSearchPrepare extends GlobalProductSearchState {}

final class GlobalProductSearchInitial extends GlobalProductSearchState {}

final class GlobalProductSearchSuccess extends GlobalProductSearchState {
  final GlobalProductSearchModel model;

  const GlobalProductSearchSuccess({required this.model});

  @override
  List<Object> get props => ["model: $model"];
}

final class GlobalProductSearchFailure extends GlobalProductSearchState {
  final BaseException error;

  const GlobalProductSearchFailure({required this.error});

  @override
  List<Object> get props => ["error: $error"];
}
