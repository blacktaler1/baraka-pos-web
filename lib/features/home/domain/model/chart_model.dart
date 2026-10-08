import 'package:baraka_pos/shared/domain/domain.dart';

final class ChartModel extends Model {
  final List labels;
  final List sales;
  final List purchase;
  final num totalSales;
  final num totalPurchase;

  const ChartModel({
    required this.labels,
    required this.sales,
    required this.purchase,
    required this.totalSales,
    required this.totalPurchase,
  });
  @override
  List<String> get props => [
        "labels: $labels",
        "sales: $sales",
        "purchase: $purchase",
        "totalSales: $totalSales",
        "totalPurchase: $totalPurchase",
      ];
}
