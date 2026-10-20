part of 'product_history_bloc.dart';

sealed class ProductHistoryState extends Equatable {
  const ProductHistoryState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(ProductHistoryModel model, bool loadingMore) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      ProductHistoryInitial() => initial(),
      ProductHistoryPrepare() => inPrepare(),
      ProductHistoryLoadingMore(:final model) => success(model, true),
      ProductHistorySuccess(:final model) => success(model, false),
      ProductHistoryFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(ProductHistoryModel model, bool loadingMore)? success,
    T Function(BaseException error)? failure,
    required T Function() orElse,
  }) {
    return when(
      initial: initial ?? orElse,
      inPrepare: inPrepare ?? orElse,
      failure: failure ?? (_) => orElse(),
      success: success ?? (_, __) => orElse(),
    );
  }

  T? whenOrNull<T>({
    T Function()? inPrepare,
    T Function(ProductHistoryModel model, bool loadingMore)? success,
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

final class ProductHistoryInitial extends ProductHistoryState {}

final class ProductHistoryPrepare extends ProductHistoryState {}

final class ProductHistorySuccess extends ProductHistoryState {
  final ProductHistoryModel model;

  const ProductHistorySuccess({required this.model});

  @override
  List<Object> get props => ["model: $model"];
}

/// Keyingi sahifa yuklanmoqda — mavjud ro'yxat ko'rinib turadi
final class ProductHistoryLoadingMore extends ProductHistorySuccess {
  const ProductHistoryLoadingMore({required super.model});

  @override
  List<Object> get props => ["loadingMore", "model: $model"];
}

final class ProductHistoryFailure extends ProductHistoryState {
  final BaseException error;

  const ProductHistoryFailure({required this.error});

  @override
  List<Object> get props => ["error: $error"];
}
