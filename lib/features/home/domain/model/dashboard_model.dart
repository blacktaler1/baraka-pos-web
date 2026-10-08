import 'package:baraka_pos/features/home/domain/domain.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class DashboardModel extends Model {
  final CardsModel cards;
  final ChartModel charts;
  final List topProducts;

  const DashboardModel({
    required this.cards,
    required this.charts,
    required this.topProducts,
  });

  @override
  List<String> get props => [
        "cards: $cards",
        "charts: $charts",
        "bestSeller: $topProducts",
      ];
}
