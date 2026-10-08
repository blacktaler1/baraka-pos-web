import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';

final class CashShiftDto extends JsonDto<CashShiftModel> {
  final Json json;

  const CashShiftDto.fromJson(this.json) : super.fromJson(json);

  @override
  CashShiftModel model() {
    return CashShiftModel(
      id: json.integer("id"),
      cashierName: json.object("cashier").text("name"),
      openedAt: json.text("opened_at"),
      closedAt: json.text("closed_at"),
      isOpen: json.flag("is_open"),
      openingCash: json.text("opening_cash", fallback: "0"),
      closingCash: json.text("closing_cash"),
      expectedCash: json.text("expected_cash", fallback: "0"),
      difference: json.text("difference"),
      note: json.text("note"),
      cashSales: json.text("cash_sales", fallback: "0"),
      cardSales: json.text("card_sales", fallback: "0"),
      debtSales: json.text("debt_sales", fallback: "0"),
      debtCollected: json.text("debt_collected", fallback: "0"),
      cashRefunds: json.text("cash_refunds", fallback: "0"),
      otherRefunds: json.text("other_refunds", fallback: "0"),
      transactionsCount: json.integer("transactions_count"),
    );
  }
}
