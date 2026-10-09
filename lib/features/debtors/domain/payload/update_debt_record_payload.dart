import '../../../../shared/shared.dart';

/// Qarz yozuvini tahrirlash: faqat berilgan maydonlar yuboriladi
final class UpdateDebtRecordPayload extends Payload {
  final int recordId;
  final num? debt;
  final DateTime? deadline;
  final bool clearDeadline;
  final String? description;

  const UpdateDebtRecordPayload({
    required this.recordId,
    this.debt,
    this.deadline,
    this.clearDeadline = false,
    this.description,
  });

  bool get isEmpty =>
      debt == null && deadline == null && !clearDeadline && description == null;

  Json toJson() => {
        if (debt != null) "debt": debt,
        if (clearDeadline)
          "deadline": null
        else if (deadline != null)
          "deadline": deadline!.toUtc().toIso8601String(),
        if (description != null) "description": description,
      };

  @override
  List<Object> get props => ["recordId: $recordId", "changes: ${toJson()}"];
}
