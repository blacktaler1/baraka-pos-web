import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import 'firma_collection_dto.dart';

final class AllFirmaDto extends JsonDto<AllFirmaModel> {
  final Json json;

  AllFirmaDto.fromJson(this.json) : super.fromJson(json);

  String get next => json["next"] ?? "";

  String get previous => json["previous"] ?? "";

  int get total => json.integer("total");

  FirmaCollection get results {
    final raw = json["data"];
    return FirmaCollectionDto.fromList(raw is List ? raw : []).collection();
  }

  @override
  AllFirmaModel model() => AllFirmaModel(
        next: next,
        previous: previous,
        total: total,
        results: results,
      );
}
