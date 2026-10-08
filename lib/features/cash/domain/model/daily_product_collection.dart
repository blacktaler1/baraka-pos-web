import 'package:baraka_pos/shared/shared.dart';

final class DailyProductCollection extends Collection<DailyProductItemModel> {
  const DailyProductCollection({required super.models});
}

final class DailyProductItemModel extends Model {
  final String productName;
  final String unit;
  final String quantity;
  final String totalSales;

  const DailyProductItemModel({
    required this.productName,
    required this.unit,
    required this.quantity,
    required this.totalSales,
  });

  @override
  List<String> get props => [
        "productName: $productName",
        "unit: $unit",
        "quantity: $quantity",
        "totalSales: $totalSales",
      ];
}
