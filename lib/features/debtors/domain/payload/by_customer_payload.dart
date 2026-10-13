import '../../../../shared/shared.dart';

final class ByCustomerPayload extends Payload {
  final int id;

  /// unpaid, paid yoki all
  final String status;

  const ByCustomerPayload({required this.id, this.status = 'unpaid'});

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
