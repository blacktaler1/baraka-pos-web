import '../../../../shared/domain/domain.dart';
import 'expense_model.dart';

final class ExpenseCollection extends Collection<ExpenseModel> {
  const ExpenseCollection({required super.models});
  @override
  List<String> get props => [
        "collection: $models",
      ];
}
