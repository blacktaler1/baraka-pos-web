import 'package:baraka_pos/shared/shared.dart';

final class UpdateExpensePayload extends Payload {
  final int id;
  final String title;
  final int amount;

  /// Yaratishda: null — kategoriyasiz. Tahrirda: null — o'zgarmaydi, 0 — olib tashlash
  final int? categoryId;

  const UpdateExpensePayload({
    required this.id,
    required this.title,
    required this.amount,
    this.categoryId,
  });

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
        "amount: $amount",
        "category: $categoryId",
      ];
}
