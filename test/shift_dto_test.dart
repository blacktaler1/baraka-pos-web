import 'package:baraka_pos/features/shift/shift.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('current shift is null when none is open', () {
    expect(const CurrentShiftDto.fromJson({"shift": null}).model().shift, isNull);
  });

  test('shift list parses counters and open/closed state', () {
    final model = const GetShiftsDto.fromJson({
      "next": "abc",
      "previous": null,
      "total": 2,
      "data": [
        {
          "id": 7,
          "cashier": {"id": 1, "name": "Ali"},
          "opened_at": "2026-10-04T08:00:00Z",
          "closed_at": "2026-10-04T20:00:00Z",
          "is_open": false,
          "opening_cash": "100.00",
          "closing_cash": "145.00",
          "expected_cash": "150.00",
          "difference": "-5.00",
          "cash_sales": "30.00",
          "transactions_count": 3,
        },
        {"id": 8, "cashier": {"name": "Vali"}, "is_open": true, "closing_cash": null, "difference": null},
      ],
    }).model();

    expect(model.next, "abc");
    expect(model.total, 2);
    final closed = model.data.models.first;
    expect(closed.cashierName, "Ali");
    expect(closed.difference, "-5.00");
    expect(closed.transactionsCount, 3);
    final open = model.data.models.last;
    expect(open.isOpen, isTrue);
    expect(open.closingCash, "");
    expect(open.difference, "");
  });
}
