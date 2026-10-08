import 'package:baraka_pos/features/home/data/data.dart';
import 'package:baraka_pos/features/home/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class DashboardDto extends JsonDto<DashboardModel> {
  final Json json;

  DashboardDto.fromJson(this.json) : super.fromJson(json);

  CardsDto get card => CardsDto.fromJson(json.object("cards"));

  ChartDto get chart => ChartDto.fromJson(json.object("chart"));

  List get topProducts => json.items("top_products");

  @override
  DashboardModel model() {
    return DashboardModel(
      cards: card.model(),
      charts: chart.model(),
      topProducts: topProducts,
    );
  }
}
