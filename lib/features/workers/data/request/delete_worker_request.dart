import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class DeleteWorkerRequest extends RemoteRequest<DeleteWorkerPayload> {
  final int id;
  DeleteWorkerRequest.fromPayload(super.payload)
      : id = payload.id,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
