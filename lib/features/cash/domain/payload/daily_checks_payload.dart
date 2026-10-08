import 'package:baraka_pos/shared/shared.dart';

final class DailyChecksPayload extends Payload {
  final String from;
  final String to;

  const DailyChecksPayload({
    this.from = "",
    this.to = "",
  });

  @override
  List<Object> get props => [
        "from: $from",
        "to: $to",
      ];
}
