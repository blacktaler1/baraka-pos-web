import '../../../../shared/shared.dart';

/// Firma qarzi yoki to'lov yozuvini o'chirish
final class DeleteLoanPayload extends Payload {
  final int firmaId;
  final int loanId;

  const DeleteLoanPayload({required this.firmaId, required this.loanId});

  @override
  List<Object> get props => ["firma: $firmaId", "loan: $loanId"];
}
