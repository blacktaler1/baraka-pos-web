import 'package:baraka_pos/shared/domain/domain.dart';

final class GetShiftsPayload extends Payload {
  final String cursor;
  final int pageSize;
  final String from;
  final String to;

  const GetShiftsPayload({
    required this.cursor,
    required this.pageSize,
    required this.from,
    required this.to,
  });

  @override
  List<String> get props => [
        "cursor: $cursor",
        "pageSize: $pageSize",
        "from: $from",
        "to: $to",
      ];
}
