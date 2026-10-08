import 'package:baraka_pos/shared/domain/domain.dart';

final class GeneratedCodeModel extends Model {
  final String generatedCode;

  const GeneratedCodeModel({
    required this.generatedCode,
  });

  @override
  List<String> get props => [
        "generated_code: $generatedCode",
      ];
}
