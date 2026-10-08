import 'package:baraka_pos/shared/shared.dart';

final class CreateExpensePayload extends Payload {
  final String title;
  final int amount;

  const CreateExpensePayload({
    required this.title,
    required this.amount,
  });

  @override
  List<String> get props => [
        "title: $title",
        "amount: $amount",
      ];
}
