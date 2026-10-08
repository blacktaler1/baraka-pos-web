import 'package:baraka_pos/shared/domain/domain.dart';

final class CreateLoanPayload extends Payload {
  final String title;
  final int paid;
  final int debt;
  final int firmaId;

  const CreateLoanPayload({
    required this.title,
    required this.paid,
    required this.debt,
    required this.firmaId,
  });

  @override
  List<String> get props => [
        "title: $title",
        "paid: $paid",
        "debt: $debt",
        "id: $firmaId",
      ];
}
