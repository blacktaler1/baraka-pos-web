part of 'get_turnover_bloc.dart';

final class GetTurnoverEvent extends Equatable {
  final String period;
  final String cursor;
  final int pageSize;

  const GetTurnoverEvent(
      {required this.period, required this.cursor, required this.pageSize});

  @override
  List<Object> get props => [
        "period: $period",
        "cursor: $cursor",
        "pageSize: $pageSize",
      ];
}
