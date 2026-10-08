import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/payload/by_customer_history_payload.dart';

final class ByCustomerHistoryRequest
    extends RemoteRequest<ByCustomerHistoryPayload> {
  final int id;
  final bool history;
  ByCustomerHistoryRequest.fromPayload(super.payload)
      : id = payload.id,
        history = payload.history,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        "history": history.toString(),
      };
}
