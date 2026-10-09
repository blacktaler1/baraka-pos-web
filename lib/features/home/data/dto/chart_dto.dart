import 'package:baraka_pos/features/home/domain/domain.dart';
import '../../../../shared/shared.dart';

final class ChartDto extends JsonDto<ChartModel> {
  final Json json;

  ChartDto.fromJson(this.json) : super.fromJson(json);

  List get labels => json.items("labels");

  List get sales => json.items("sales");

  List get purchases => json.items("purchases");

  num get totalSales => json.number("total_sales");

  /// Ombor kirimlari (firmalardan sotib olingan mol)
  num get totalPurchases => json.number("total_purchases");

  @override
  ChartModel model() {
    return ChartModel(
      labels: labels,
      sales: sales,
      purchase: purchases,
      totalSales: totalSales,
      totalPurchase: totalPurchases,
    );
  }
}
