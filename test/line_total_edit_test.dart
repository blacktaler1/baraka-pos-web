import 'package:baraka_pos/features/cash/cash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

/// Yuborilgan narx o'zgarishlarini yozib oladi
class _SpyCartBloc extends CartBloc {
  final prices = <String>[];

  @override
  void add(CartEvent event) {
    if (event is UpdateItemPriceEvent) prices.add(event.newPrice);
  }
}

void main() {
  Future<_SpyCartBloc> pumpRow(WidgetTester tester, double quantity) async {
    final bloc = _SpyCartBloc();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BlocProvider<CartBloc>.value(
          value: bloc,
          child: SizedBox(
            width: 700,
            child: ProductRow(
              id: 1,
              title: "Fanar",
              stock: "10",
              price: "270000",
              quantity: quantity,
              unit: "dona",
              cash: true,
              onDelete: () {},
              updateQuantity: (_, __) {},
            ),
          ),
        ),
      ),
    ));
    return bloc;
  }

  Future<void> editTotal(WidgetTester tester, String value) async {
    final total = find.textContaining("270 000 ").last;
    await tester.tap(total);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(total);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, value);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  testWidgets('jami summa o\'zgarsa narx qayta hisoblanadi', (tester) async {
    final bloc = await pumpRow(tester, 1);
    await editTotal(tester, "250000");
    expect(bloc.prices, ["250000"]);
    expect(find.textContaining("250 000"), findsWidgets);
  });

  testWidgets('bo\'linmaydigan summada narx tiyingacha yaxlitlanadi',
      (tester) async {
    final bloc = await pumpRow(tester, 3);
    // 3 x 270 000 = 810 000 ko'rinadi; 800 000 kiritamiz
    final total = find.textContaining("810 000").last;
    await tester.tap(total);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(total);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, "800000");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(bloc.prices, ["266666.67"]);
  });
}
