import 'package:baraka_pos/shared/domain/domain.dart';

final class GetWriteOffsPayload extends Payload {
  final String cursor;
  final int pageSize;

  const GetWriteOffsPayload({
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<String> get props => [
        "cursor: $cursor",
        "pageSize: $pageSize",
      ];
}
