import '../../../../shared/shared.dart';

/// Firma qarzini tahrirlash: tavsif va qolgan qarz (faqat o'zgarganlari)
final class UpdateLoanPayload extends Payload {
  final int firmaId;
  final int loanId;
  final String? title;
  final num? debt;

  const UpdateLoanPayload({
    required this.firmaId,
    required this.loanId,
    this.title,
    this.debt,
  });

  bool get isEmpty => title == null && debt == null;

  Json toJson() => {
        if (title != null) "title": title,
        if (debt != null) "debt": debt,
      };

  @override
  List<Object> get props => ["loan: $loanId", "changes: ${toJson()}"];
}
