import '../../../../shared/shared.dart';

final class GetProfitCardPayload extends Payload {
  final String period;
  final String cursor;
  final int pageSize;

  const GetProfitCardPayload({
    required this.period,
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "period: $period",
        "cursor: $cursor",
        "page_size: $pageSize",
      ];
}
