import 'package:baraka_pos/shared/shared.dart';

final class CreateExpensePayload extends Payload {
  final String title;
  final int amount;

  /// Yaratishda: null — kategoriyasiz. Tahrirda: null — o'zgarmaydi, 0 — olib tashlash
  final int? categoryId;

  const CreateExpensePayload({
    required this.title,
    required this.amount,
    this.categoryId,
  });

  @override
  List<String> get props => [
        "title: $title",
        "amount: $amount",
        "category: $categoryId",
      ];
}
