import 'package:baraka_pos/shared/domain/domain.dart';

final class CloseShiftPayload extends Payload {
  final int id;
  final int closingCash;
  final String note;

  const CloseShiftPayload({
    required this.id,
    required this.closingCash,
    required this.note,
  });

  @override
  List<String> get props => [
        "id: $id",
        "closingCash: $closingCash",
        "note: $note",
      ];
}
