import 'package:baraka_pos/shared/domain/domain.dart';
import '../model/stock_line_input.dart';

final class CreateReceiptPayload extends Payload {
  final int firmaId;
  final int paidAmount;
  final String note;
  final List<StockLineInput> items;

  const CreateReceiptPayload({
    required this.firmaId,
    required this.paidAmount,
    required this.note,
    required this.items,
  });

  @override
  List<String> get props => [
        "firmaId: $firmaId",
        "paidAmount: $paidAmount",
        "note: $note",
        "items: $items",
      ];
}
