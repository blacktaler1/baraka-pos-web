import 'package:baraka_pos/shared/domain/domain.dart';
import '../model/stock_line_input.dart';

final class CreateWriteOffPayload extends Payload {
  final String reason;
  final String note;
  final List<StockLineInput> items;

  const CreateWriteOffPayload({
    required this.reason,
    required this.note,
    required this.items,
  });

  @override
  List<String> get props => [
        "reason: $reason",
        "note: $note",
        "items: $items",
      ];
}
