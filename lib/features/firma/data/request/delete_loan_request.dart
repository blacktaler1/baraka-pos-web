import 'package:baraka_pos/shared/shared.dart';

import '../../domain/payload/delete_loan_payload.dart';

final class DeleteLoanRequest extends RemoteRequest<DeleteLoanPayload> {
  final int firmaId;
  final int loanId;

  DeleteLoanRequest.fromPayload(super.payload)
      : firmaId = payload.firmaId,
        loanId = payload.loanId,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
