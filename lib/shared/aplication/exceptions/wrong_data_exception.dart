import '../aplication.dart';

final class WrongDataException extends BaseException {
  final String description;
  const WrongDataException({
    required super.message,
    required this.description,
  });

  @override
  List<String> get props => [
        "title: $message",
        'description: $description',
      ];
}
