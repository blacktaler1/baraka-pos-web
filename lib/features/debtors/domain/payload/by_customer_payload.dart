import '../../../../shared/shared.dart';

final class ByCustomerPayload extends Payload {
  final int id;

  const ByCustomerPayload({required this.id});

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
