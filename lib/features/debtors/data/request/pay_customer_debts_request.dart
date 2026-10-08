import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/pay_customer_debts_payload.dart';

final class PayCustomerDebtsRequest
    extends RemoteRequest<PayCustomerDebtsPayload> {
  final int customerId;
  final String amount;

  PayCustomerDebtsRequest.fromPayload(super.payload)
      : customerId = payload.customerId,
        amount = payload.amount,
        super.fromPayload();

  @override
  Json data() => {
        "amount": amount,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
