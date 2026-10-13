import 'package:bloc/bloc.dart';

import '../../../domain/model/expense_category_model.dart';
import '../../../domain/payload/expense_category_payload.dart';
import '../../../domain/repository/expenses_repository.dart';

/// Xarajat kategoriyalari. Holat — null bo'lsa hali yuklanmagan.
/// Amallar xato bo'lsa xabar matnini qaytaradi.
class ExpenseCategoriesCubit extends Cubit<ExpenseCategoriesModel?> {
  final ExpensesRepository repository;

  ExpenseCategoriesCubit({required this.repository}) : super(null);

  Future<void> load() async {
    final result = await repository.getExpenseCategories();
    result.when(
      success: (model) {
        if (!isClosed) emit(model);
      },
      // Xato holatda ham cheksiz yuklanish bo'lmasligi uchun
      failure: (error) {
        if (!isClosed) emit(ExpenseCategoriesModel.failed(error.message));
      },
    );
  }

  Future<void> loadIfNeeded() async {
    if (state == null || state?.error != null) await load();
  }

  Future<(ExpenseCategoryModel?, String?)> create(String title) async {
    final result = await repository.createExpenseCategory(
      payload: ExpenseCategoryPayload(title: title),
    );
    return result.when(
      success: (model) {
        load();
        return (model, null);
      },
      failure: (error) => (null, error.message),
    );
  }

  Future<String?> rename(int id, String title) async {
    final result = await repository.updateExpenseCategory(
      payload: ExpenseCategoryPayload(id: id, title: title),
    );
    return result.when(
      success: (_) {
        load();
        return null;
      },
      failure: (error) => error.message,
    );
  }

  Future<String?> delete(int id) async {
    final result = await repository.deleteExpenseCategory(
      payload: ExpenseCategoryPayload(id: id),
    );
    return result.when(
      success: (_) {
        load();
        return null;
      },
      failure: (error) => error.message,
    );
  }
}
