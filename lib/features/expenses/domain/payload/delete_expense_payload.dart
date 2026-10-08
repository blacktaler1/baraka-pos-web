import 'package:baraka_pos/shared/shared.dart';

final class DeleteExpensePayload extends Payload {
  final int id;

  const DeleteExpensePayload({
    required this.id,
  });

  @override
  List<String> get props => [
        "id: $id",
      ];
}
