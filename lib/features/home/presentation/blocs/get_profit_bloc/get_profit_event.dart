part of 'get_profit_bloc.dart';

final class GetProfitEvent extends Equatable {
  final String period;
  final String cursor;
  final int pageSize;

  const GetProfitEvent(
      {required this.period, required this.cursor, required this.pageSize});

  @override
  List<Object> get props =>
      ["period: $period", "cursor: $cursor", "page_size: $pageSize"];
}
