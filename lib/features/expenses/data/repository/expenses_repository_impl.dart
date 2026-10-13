import 'package:baraka_pos/features/expenses/data/data.dart';
import 'package:baraka_pos/features/expenses/domain/domain.dart';
import 'package:baraka_pos/features/global/domain/model/no_content_model.dart';
import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

final class ExpensesRepositoryImpl extends ExpensesRepository {
  final ExpensesRemoteSource remote;

  ExpensesRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Safed<BaseException, ExpenseModel>> createExpense({
    required CreateExpensePayload payload,
  }) async {
    final result = await remote.createExpense(
        request: CreateExpenseRequest.fromPayload(payload));
    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, NoContentModel>> deleteExpense({
    required DeleteExpensePayload payload,
  }) async {
    final result = await remote.deleteExpense(
        request: DeleteExpenseRequest.fromPayload(payload));
    return result.map(
      success: (dto) => NoContentModel(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, GetExpensesModel>> getExpenses(
      {required GetExpensesPayload payload}) async {
    final result = await remote.getExpenses(
        request: GetExpensesRequest.fromPayload(payload));

    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, ExpenseModel>> updateExpense(
      {required UpdateExpensePayload payload}) async {
    final result = await remote.updateExpense(
        request: UpdateExpenseRequest.fromPayload(payload));
    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, ExpenseCategoriesModel>>
      getExpenseCategories() async {
    final result = await remote.getExpenseCategories(
        request: ExpenseCategoryRequest.fromPayload(
            const ExpenseCategoryPayload()));
    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, ExpenseCategoryModel>> createExpenseCategory(
      {required ExpenseCategoryPayload payload}) async {
    final result = await remote.createExpenseCategory(
        request: ExpenseCategoryRequest.fromPayload(payload));
    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, ExpenseCategoryModel>> updateExpenseCategory(
      {required ExpenseCategoryPayload payload}) async {
    final result = await remote.updateExpenseCategory(
        request: ExpenseCategoryRequest.fromPayload(payload));
    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, NoContentModel>> deleteExpenseCategory(
      {required ExpenseCategoryPayload payload}) async {
    final result = await remote.deleteExpenseCategory(
        request: ExpenseCategoryRequest.fromPayload(payload));
    return result.map(
      success: (_) => NoContentModel(),
      failure: (e) => e,
    );
  }
}
