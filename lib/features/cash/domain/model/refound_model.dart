import '../../../../shared/domain/domain.dart';

final class RefoundModel extends Model {
  final String status;
  final String message;

  const RefoundModel({
    required this.status,
    required this.message,
  });

  @override
  List<String> get props => [
        "status: $status",
        "message: $message",
      ];
}
