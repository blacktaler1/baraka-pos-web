import 'package:baraka_pos/features/store/data/data.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';
import '../../../../shared/shared.dart';

final class GlobalProductSearchDto extends JsonDto<GlobalProductSearchModel> {
  final Json json;

  GlobalProductSearchDto.fromJson(this.json) : super.fromJson(json);

  String get next => json["next"] ?? "";

  String get previous => json["previous"] ?? "";

  GlobalProductCollectionDto get results => GlobalProductCollectionDto.fromList(
        json["results"],
      );

  @override
  GlobalProductSearchModel model() {
    return GlobalProductSearchModel(
      next: next,
      previous: previous,
      result: results.collection(),
    );
  }
}
