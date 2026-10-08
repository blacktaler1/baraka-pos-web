import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class CreateLoanRequest extends RemoteRequest<CreateLoanPayload> {
  final String title;
  final int paid;
  final int debt;
  final int firmaId;

  CreateLoanRequest.fromPayload(super.payload)
      : title = payload.title,
        debt = payload.debt,
        paid = payload.paid,
        firmaId = payload.firmaId,
        super.fromPayload();

  @override
  Json data() => {
        "title": title,
        "debt": debt,
        "paid": paid,
      };

  @override
  Map<String, String> path() => {
        'firma_id': firmaId.toString(),
      };

  @override
  Map<String, String> query() => {};
}
