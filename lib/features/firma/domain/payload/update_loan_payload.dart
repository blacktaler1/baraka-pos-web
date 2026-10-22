import '../../../../shared/shared.dart';

/// Firma qarzi yoki to'lovini tahrirlash: tavsif, qarz, to'langan (faqat o'zgarganlari)
final class UpdateLoanPayload extends Payload {
  final int firmaId;
  final int loanId;
  final String? title;
  final num? debt;
  final num? paid;

  const UpdateLoanPayload({
    required this.firmaId,
    required this.loanId,
    this.title,
    this.debt,
    this.paid,
  });

  bool get isEmpty => title == null && debt == null && paid == null;

  Json toJson() => {
        if (title != null) "title": title,
        if (debt != null) "debt": debt,
        if (paid != null) "paid": paid,
      };

  @override
  List<Object> get props => ["loan: $loanId", "changes: ${toJson()}"];
}
