import 'package:baraka_pos/features/expenses/expenses.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('xarajat DTO kategoriyani o\'qiydi', () {
    final model = const ExpenseDto.fromJson({
      "id": 1,
      "title": "oktabr",
      "amount": "3000000.00",
      "warehouse": 2,
      "category": 5,
      "category_title": "Ijara",
    }).model();
    expect(model.categoryId, 5);
    expect(model.categoryTitle, "Ijara");

    final plain = const ExpenseDto.fromJson({"id": 2, "category": null}).model();
    expect(plain.categoryId, isNull);
    expect(plain.categoryTitle, isNull);
  });

  test('kategoriyalar ro\'yxati va kategoriyasizlar', () {
    final model = const ExpenseCategoriesDto.fromJson({
      "data": [
        {"id": 1, "title": "Ijara", "expenses_count": 2, "total_amount": "5000000.00"},
      ],
      "uncategorized": {"expenses_count": 1, "total_amount": 15000},
    }).model();
    expect(model.categories.single.title, "Ijara");
    expect(model.categories.single.totalAmount, 5000000);
    expect(model.uncategorizedCount, 1);
    expect(model.uncategorizedAmount, 15000);
  });

  test('tahrirda kategoriya: null — o\'zgarmaydi, 0 — olib tashlanadi', () {
    Map<String, dynamic> data(int? id) => UpdateExpenseRequest.fromPayload(
            UpdateExpensePayload(id: 1, title: "", amount: 0, categoryId: id))
        .data();
    expect(data(null).containsKey("category"), isFalse);
    expect(data(0), {"category": null});
    expect(data(7), {"category": 7});
  });

  test('ro\'yxat filtri so\'rovga qo\'shiladi', () {
    final query = GetExpensesRequest.fromPayload(
      const GetExpensesPayload(cursor: "", pageSize: "10", category: "none"),
    ).query();
    expect(query["category"], "none");
    expect(
      GetExpensesRequest.fromPayload(
        const GetExpensesPayload(cursor: "", pageSize: "10"),
      ).query().containsKey("category"),
      isFalse,
    );
  });
}
