import '../../../../shared/domain/domain.dart';
import 'daily_product_collection.dart';
import 'user_daily_check_model.dart';

final class DailyChecksModel extends Model {
  final String totalSum;
  final String totalCash;
  final String totalCard;
  final String totalDebt;
  final UserDailyCheckModel user;
  final DailyProductCollection product;
  final String requestingTime;

  const DailyChecksModel({
    required this.totalSum,
    required this.totalCash,
    required this.totalCard,
    required this.totalDebt,
    required this.user,
    required this.product,
    required this.requestingTime,
  });

  @override
  List<String> get props => [
        "totalSum: $totalSum",
        "totalCash: $totalCash",
        "totalCard: $totalCard",
        "totalDebt: $totalDebt",
        "user: $user",
        "product: $product",
        "requestingTime: $requestingTime",
      ];
}
