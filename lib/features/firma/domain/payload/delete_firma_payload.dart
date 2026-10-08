import 'package:baraka_pos/shared/domain/domain.dart';

final class DeleteFirmaPayload extends Payload {
  final int id;

  const DeleteFirmaPayload({required this.id});

  @override
  List<Object> get props => ["id: $id"];
}
