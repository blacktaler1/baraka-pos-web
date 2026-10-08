import '../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../shared/aplication/utils/safed.dart';
import '../../../global/domain/model/no_content_model.dart';
import '../model/expense_model.dart';
import '../model/get_expenses_model.dart';
import '../payload/create_expense_payload.dart';
import '../payload/delete_expense_payload.dart';
import '../payload/get_expenses_payload.dart';
import '../payload/update_expense_payload.dart';

abstract class ExpensesRepository {
  Future<Safed<BaseException, GetExpensesModel>> getExpenses({
    required GetExpensesPayload payload,
  });

  Future<Safed<BaseException, ExpenseModel>> createExpense({
    required CreateExpensePayload payload,
  });

  Future<Safed<BaseException, ExpenseModel>> updateExpense({
    required UpdateExpensePayload payload,
  });

  Future<Safed<BaseException, NoContentModel>> deleteExpense({
    required DeleteExpensePayload payload,
  });
}
