import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class CreateCustomerRequest extends RemoteRequest<CreateCustomerPayload> {
  final String fullName;
  final String phone;
  final String address;

  CreateCustomerRequest.fromPayload(super.payload)
      : fullName = payload.fullName,
        phone = payload.phone,
        address = payload.address,
        super.fromPayload();

  @override
  Json data() => {
        "full_name": fullName,
        "phone": phone,
        "address": address,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
