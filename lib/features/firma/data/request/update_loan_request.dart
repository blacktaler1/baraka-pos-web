import 'package:baraka_pos/shared/shared.dart';

import '../../domain/payload/update_loan_payload.dart';

final class UpdateLoanRequest extends RemoteRequest<UpdateLoanPayload> {
  final Json body;

  UpdateLoanRequest.fromPayload(super.payload)
      : body = payload.toJson(),
        super.fromPayload();

  @override
  Json data() => body;

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
