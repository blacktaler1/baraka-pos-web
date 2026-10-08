import '../../../../shared/domain/domain.dart';

final class DeleteWorkerPayload extends Payload {
  final int id;
  const DeleteWorkerPayload({required this.id});
  @override
  List<Object> get props => ["id: $id"];
}
