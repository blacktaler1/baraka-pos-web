import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/payload/create_expense_payload.dart';

final class CreateExpenseRequest extends RemoteRequest<CreateExpensePayload> {
  final String title;
  final int amount;

  CreateExpenseRequest.fromPayload(super.payload)
      : title = payload.title,
        amount = payload.amount,
        super.fromPayload();

  @override
  Json data() => {
        "title": title,
        "amount": amount,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
