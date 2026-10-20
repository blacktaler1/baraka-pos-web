import 'package:baraka_pos/shared/domain/domain.dart';

final class ProductHistoryPayload extends Payload {
  final int pk;

  /// Bo'sh — hammasi; aks holda vergul bilan: "add,initial,inv_plus"
  final String type;
  final int offset;
  final int limit;

  const ProductHistoryPayload({
    required this.pk,
    this.type = "",
    this.offset = 0,
    this.limit = 30,
  });

  @override
  List<Object> get props => [
        "pk: $pk",
        "type: $type",
        "offset: $offset",
        "limit: $limit",
      ];
}
