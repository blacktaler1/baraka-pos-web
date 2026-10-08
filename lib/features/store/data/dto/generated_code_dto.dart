import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class GeneratedCodeDto extends JsonDto<GeneratedCodeModel> {
  final Json json;

  GeneratedCodeDto.fromJson(this.json) : super.fromJson(json);

  String get generatedCode => json['generated_code'] ?? "";

  @override
  GeneratedCodeModel model() {
    return GeneratedCodeModel(
      generatedCode: generatedCode,
    );
  }
}
