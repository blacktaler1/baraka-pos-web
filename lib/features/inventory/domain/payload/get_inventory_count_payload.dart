import 'package:baraka_pos/shared/domain/domain.dart';

final class GetInventoryCountPayload extends Payload {
  final int id;

  const GetInventoryCountPayload({
    required this.id,
  });

  @override
  List<String> get props => [
        "id: $id",
      ];
}
