import 'package:baraka_pos/shared/domain/domain.dart';

final class CashShiftModel extends Model {
  final int id;
  final String cashierName;
  final String openedAt;
  final String closedAt;
  final bool isOpen;
  final String openingCash;
  final String closingCash;
  final String expectedCash;
  final String difference;
  final String note;
  final String cashSales;
  final String cardSales;
  final String debtSales;
  final String debtCollected;
  final String cashRefunds;
  final String otherRefunds;
  final int transactionsCount;

  const CashShiftModel({
    required this.id,
    required this.cashierName,
    required this.openedAt,
    required this.closedAt,
    required this.isOpen,
    required this.openingCash,
    required this.closingCash,
    required this.expectedCash,
    required this.difference,
    required this.note,
    required this.cashSales,
    required this.cardSales,
    required this.debtSales,
    required this.debtCollected,
    required this.cashRefunds,
    required this.otherRefunds,
    required this.transactionsCount,
  });

  @override
  List<String> get props => [
        "id: $id",
        "cashier: $cashierName",
        "opened_at: $openedAt",
        "closed_at: $closedAt",
        "opening_cash: $openingCash",
        "closing_cash: $closingCash",
        "expected_cash: $expectedCash",
        "difference: $difference",
        "transactions_count: $transactionsCount",
      ];
}
