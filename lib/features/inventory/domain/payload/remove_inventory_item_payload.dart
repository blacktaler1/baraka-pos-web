import 'package:baraka_pos/shared/domain/domain.dart';

final class RemoveInventoryItemPayload extends Payload {
  final int countId;
  final int itemId;

  const RemoveInventoryItemPayload({
    required this.countId,
    required this.itemId,
  });

  @override
  List<String> get props => [
        "countId: $countId",
        "itemId: $itemId",
      ];
}
