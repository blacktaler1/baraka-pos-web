import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/payload/expense_category_payload.dart';

final class ExpenseCategoryRequest
    extends RemoteRequest<ExpenseCategoryPayload> {
  final int id;
  final String title;

  ExpenseCategoryRequest.fromPayload(super.payload)
      : id = payload.id,
        title = payload.title,
        super.fromPayload();

  @override
  Json data() => {
        if (title.isNotEmpty) "title": title,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
