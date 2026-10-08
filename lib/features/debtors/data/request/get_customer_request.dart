import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/payload/get_customer_payload.dart';

final class GetCustomerRequest extends RemoteRequest<GetCustomerPayload> {
  final String search;
  final String pageSize;
  final String cursor;

  GetCustomerRequest.fromPayload(super.payload)
      : search = payload.search,
        pageSize = payload.pageSize,
        cursor = payload.cursor,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        "cursor": cursor,
        "page_size": pageSize,
        "search": search,
      };
}
