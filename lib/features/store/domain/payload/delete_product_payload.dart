import 'package:baraka_pos/shared/domain/domain.dart';

final class DeleteProductPayload extends Payload {
  final int id;

  const DeleteProductPayload({required this.id});

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
