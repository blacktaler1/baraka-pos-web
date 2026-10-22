import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

/// Zaxira tarixidagi bitta yozuv (kirim/chiqim) — tahrirlash yoki o'chirish.
/// Mahsulot qoldig'i o'zgarmaydi, faqat jurnal yozuvi to'g'rilanadi.
final class HistoryEntryPayload extends Payload {
  final int pk;
  final int entryId;
  final double? quantity;
  final String? note;

  const HistoryEntryPayload({
    required this.pk,
    required this.entryId,
    this.quantity,
    this.note,
  });

  Json toJson() => {
        if (quantity != null) "quantity": quantity,
        if (note != null) "note": note,
      };

  @override
  List<Object> get props => [
        "pk: $pk",
        "entryId: $entryId",
        "changes: ${toJson()}",
      ];
}
