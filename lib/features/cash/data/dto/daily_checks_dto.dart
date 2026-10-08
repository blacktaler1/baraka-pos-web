import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/shared.dart';

final class DailyChecksDto extends JsonDto<DailyChecksModel> {
  final Json json;

  DailyChecksDto.fromJson(this.json) : super.fromJson(json);

  String get totalSum =>
      parseAmount(json["total_sum"]?.toString()).toStringAsFixed(0);
  String get totalCash =>
      parseAmount(json["total_cash"]?.toString()).toStringAsFixed(0);
  String get totalCard =>
      parseAmount(json["total_card"]?.toString()).toStringAsFixed(0);
  String get totalDebt =>
      parseAmount(json["total_debt"]?.toString()).toStringAsFixed(0);

  UserDailyCheckDto get user => UserDailyCheckDto.fromJson(json.object("user"));

  DailyProductCollectionDto get product => DailyProductCollectionDto.fromList(
        json.items("products"),
      );

  String get requestingTime => json["requesting_time"]?.toString() ?? "";

  @override
  DailyChecksModel model() {
    return DailyChecksModel(
      totalSum: totalSum,
      totalCash: totalCash,
      totalCard: totalCard,
      totalDebt: totalDebt,
      user: user.model(),
      product: product.collection(),
      requestingTime: requestingTime,
    );
  }
}
