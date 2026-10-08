import 'package:baraka_pos/shared/domain/domain.dart';

final class CancelInventoryCountPayload extends Payload {
  final int id;

  const CancelInventoryCountPayload({
    required this.id,
  });

  @override
  List<String> get props => [
        "id: $id",
      ];
}
