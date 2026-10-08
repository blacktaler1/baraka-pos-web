import 'package:baraka_pos/shared/domain/domain.dart';

final class GetDashboardPayload extends Payload {
  final String cardsPeriod;
  final String chartPeriod;
  final String topProductPeriod;
  const GetDashboardPayload({
    required this.cardsPeriod,
    required this.chartPeriod,
    required this.topProductPeriod,
  });
  @override
  List<Object> get props => [
        "cardsPeriod: $cardsPeriod",
        "chartPeriod: $chartPeriod",
        "topProductPeriod: $topProductPeriod",
      ];
}
