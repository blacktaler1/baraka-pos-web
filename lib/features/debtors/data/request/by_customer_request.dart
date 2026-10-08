import 'package:baraka_pos/features/debtors/domain/payload/by_customer_payload.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class ByCustomerRequest extends RemoteRequest<ByCustomerPayload> {
  final int id;
  ByCustomerRequest.fromPayload(super.payload)
      : id = payload.id,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
