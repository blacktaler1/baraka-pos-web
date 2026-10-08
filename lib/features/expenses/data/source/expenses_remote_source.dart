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
