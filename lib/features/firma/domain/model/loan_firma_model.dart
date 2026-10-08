import '../../../../shared/domain/domain.dart';

final class LoanFirmaModel extends Model {
  final int id;
  final String title;
  final String debt;
  final String paid;
  final String created;

  const LoanFirmaModel(
      {required this.id,
      required this.title,
      required this.debt,
      required this.paid,
      required this.created});

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
        "debt: $debt",
        "paid: $paid",
        "created: $created",
      ];
}
