import 'package:baraka_pos/shared/domain/domain.dart';

final class CreateInventoryCountPayload extends Payload {
  final String note;

  const CreateInventoryCountPayload({
    required this.note,
  });

  @override
  List<String> get props => [
        "note: $note",
      ];
}
