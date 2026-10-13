import 'package:baraka_pos/features/expenses/data/data.dart';
import 'package:baraka_pos/shared/shared.dart';

import '../../../auth/presentation/screens/splash_screen.dart';

final class ExpensesRemoteSource extends RemoteSource {
  ExpensesRemoteSource({required super.client});

  Future<Safed<BaseException, GetExpensesDto>> getExpenses(
      {required GetExpensesRequest request}) async {
    return await apiGet(
      path: "/${globalUser?.warehouseUuid}/expenses/",
      request: request,
    ).map(
      success: dataFactory(GetExpensesDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ExpenseDto>> createExpense(
      {required CreateExpenseRequest request}) async {
    return await apiPost(
      path: "/${globalUser?.warehouseUuid}/expenses/",
      request: request,
    ).map(
      success: dataFactory(ExpenseDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ExpenseDto>> updateExpense(
      {required UpdateExpenseRequest request}) async {
    return await apiPatch(
            path: "/${globalUser?.warehouseUuid}/expenses/${request.id}/",
            request: request)
        .map(
      success: dataFactory(ExpenseDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ExpenseCategoriesDto>> getExpenseCategories(
      {required ExpenseCategoryRequest request}) async {
    return await apiGet(
      path: "/${globalUser?.warehouseUuid}/expenses/categories/",
      request: request,
    ).map(
      success: ExpenseCategoriesDto.fromJson,
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ExpenseCategoryDto>> createExpenseCategory(
      {required ExpenseCategoryRequest request}) async {
    return await apiPost(
      path: "/${globalUser?.warehouseUuid}/expenses/categories/",
      request: request,
    ).map(
      success: dataFactory(ExpenseCategoryDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ExpenseCategoryDto>> updateExpenseCategory(
      {required ExpenseCategoryRequest request}) async {
    return await apiPatch(
      path:
          "/${globalUser?.warehouseUuid}/expenses/categories/${request.id}/",
      request: request,
    ).map(
      success: dataFactory(ExpenseCategoryDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, Json>> deleteExpenseCategory(
      {required ExpenseCategoryRequest request}) async {
    return await apiDelete(
      path:
          "/${globalUser?.warehouseUuid}/expenses/categories/${request.id}/",
      request: request,
    );
  }

  Future<Safed<BaseException, ExpenseDto>> deleteExpense(
      {required DeleteExpenseRequest request}) async {
    return await apiDelete(
            path: "/${globalUser?.warehouseUuid}/expenses/${request.id}/",
            request: request)
        .map(
      success: dataFactory(ExpenseDto.fromJson),
      failure: (BaseException e) => e,
    );
  }
}
