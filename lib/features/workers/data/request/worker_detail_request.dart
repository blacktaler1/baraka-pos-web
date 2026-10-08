import 'package:baraka_pos/features/workers/domain/payload/payload.dart';
import 'package:baraka_pos/shared/shared.dart';

final class WorkerDetailRequest extends RemoteRequest<WorkerDetailPayload> {
  final int id;
  WorkerDetailRequest.fromPayload(super.payload)
      : id = payload.id,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {
        "id": id.toString(),
      };

  @override
  Map<String, String> query() => {};
}
