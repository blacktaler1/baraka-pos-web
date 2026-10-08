import 'package:baraka_pos/shared/domain/domain.dart';

final class GetTurnoverCardPayload extends Payload {
  final String period;
  final String cursor;
  final int pageSize;

  const GetTurnoverCardPayload({
    required this.period,
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props =>
      ["period: $period", "cursor: $cursor", "page_size: $pageSize"];
}
