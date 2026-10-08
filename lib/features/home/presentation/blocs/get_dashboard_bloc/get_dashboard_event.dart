part of 'get_dashboard_bloc.dart';

final class GetDashboardEvent extends Equatable {
  final String cardsPeriod;
  final String chartPeriod;
  final String topProductPeriod;
  const GetDashboardEvent({
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
