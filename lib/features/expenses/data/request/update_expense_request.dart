import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/payload/update_expense_payload.dart';

final class UpdateExpenseRequest extends RemoteRequest<UpdateExpensePayload> {
  final int id;
  final String title;
  final int amount;
  final int? categoryId;

  UpdateExpenseRequest.fromPayload(super.payload)
      : id = payload.id,
        title = payload.title,
        amount = payload.amount,
        categoryId = payload.categoryId,
        super.fromPayload();

  @override
  Json data() => {
        if (title.isNotEmpty) "title": title,
        if (amount != 0) "amount": amount,
        if (categoryId != null)
          "category": categoryId == 0 ? null : categoryId,
      };

  @override
  Map<String, String> path() => {
        "id": id.toString(),
      };

  @override
  Map<String, String> query() => {};
}
