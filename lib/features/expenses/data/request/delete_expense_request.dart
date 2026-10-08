import 'package:baraka_pos/features/expenses/domain/domain.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';

final class DeleteExpenseRequest extends RemoteRequest<DeleteExpensePayload> {
  final int id;

  DeleteExpenseRequest.fromPayload(super.payload)
      : id = payload.id,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {
        "id": id.toString(),
      };

  @override
  Map<String, String> query() => {};
}
