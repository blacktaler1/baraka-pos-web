import 'package:baraka_pos/shared/shared.dart';

final class ExpenseCategoryPayload extends Payload {
  final int id;
  final String title;

  const ExpenseCategoryPayload({
    this.id = 0,
    this.title = "",
  });

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
      ];
}
