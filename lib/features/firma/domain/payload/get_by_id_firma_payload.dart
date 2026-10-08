import 'package:baraka_pos/shared/domain/domain.dart';

final class GetByIdFirmaPayload extends Payload {
  final int id;

  const GetByIdFirmaPayload({
    required this.id,
  });

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
