import 'package:baraka_pos/features/workers/domain/payload/get_workers_list_payload.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class GetWorkersListRequest extends RemoteRequest<GetWorkersListPayload> {
  GetWorkersListRequest.fromPayload(super.payload) : super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
