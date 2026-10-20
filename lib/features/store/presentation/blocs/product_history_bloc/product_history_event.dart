part of 'product_history_bloc.dart';

sealed class ProductHistoryEvent extends Equatable {
  const ProductHistoryEvent();

  @override
  List<Object> get props => [];
}

final class ProductHistoryStarted extends ProductHistoryEvent {
  final int pk;
  final String type;

  /// 0 — birinchi sahifa; undan katta — ro'yxat oxiriga qo'shiladi
  final int offset;

  const ProductHistoryStarted({
    required this.pk,
    this.type = "",
    this.offset = 0,
  });

  @override
  List<Object> get props => [
        "pk: $pk",
        "type: $type",
        "offset: $offset",
      ];
}
