part of 'create_receipt_bloc.dart';

sealed class CreateReceiptEvent extends Equatable {
  const CreateReceiptEvent();

  @override
  List<Object> get props => [];
}

final class CreateReceiptStarted extends CreateReceiptEvent {
  final int firmaId;
  final int paidAmount;
  final String note;
  final List<StockLineInput> items;

  const CreateReceiptStarted({
    required this.firmaId,
    required this.paidAmount,
    required this.note,
    required this.items,
  });

  @override
  List<Object> get props => [
        "firmaId: $firmaId",
        "paidAmount: $paidAmount",
        "note: $note",
        "items: $items",
      ];
}
