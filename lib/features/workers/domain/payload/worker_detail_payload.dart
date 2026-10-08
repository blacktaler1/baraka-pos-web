import 'package:baraka_pos/shared/domain/domain.dart';

final class WorkerDetailPayload extends Payload {
  final int id;

  const WorkerDetailPayload({required this.id});
  @override
  List<Object> get props => [
        "id: $id",
      ];
}
