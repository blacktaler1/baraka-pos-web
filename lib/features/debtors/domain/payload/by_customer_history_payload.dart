import '../../../../shared/domain/domain.dart';

final class ByCustomerHistoryPayload extends Payload {
  final int id;
  final bool history;

  const ByCustomerHistoryPayload({
    required this.id,
    required this.history,
  });

  @override
  List<Object> get props => [
        "id: $id",
        "history: $history",
      ];
}
