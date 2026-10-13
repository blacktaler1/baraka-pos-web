import 'package:baraka_pos/features/expenses/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('kategoriya nomi oynasi yopilganda xato bermaydi', (tester) async {
    String? result;
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () async =>
              result = await showExpenseCategoryTitleDialog(context),
          child: const Text("open"),
        ),
      ),
    ));
    await tester.tap(find.text("open"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), "  Ijara ");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(result, "Ijara");
    expect(tester.takeException(), isNull);
  });
}
