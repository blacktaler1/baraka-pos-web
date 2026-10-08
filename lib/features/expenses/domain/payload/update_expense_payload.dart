import 'package:baraka_pos/shared/shared.dart';

final class UpdateExpensePayload extends Payload {
  final int id;
  final String title;
  final int amount;

  const UpdateExpensePayload({
    required this.id,
    required this.title,
    required this.amount,
  });

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
        "amount: $amount",
      ];
}
