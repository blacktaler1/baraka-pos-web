import 'package:baraka_pos/shared/domain/domain.dart';

final class CompleteInventoryCountPayload extends Payload {
  final int id;

  const CompleteInventoryCountPayload({
    required this.id,
  });

  @override
  List<String> get props => [
        "id: $id",
      ];
}
