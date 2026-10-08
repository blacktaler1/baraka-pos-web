import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/firma_collection.dart';
import '../../domain/model/firma_model.dart';
import 'firma_dto.dart';

final class FirmaCollectionDto
    extends JsonCollectionDto<FirmaDto, FirmaCollection, FirmaModel> {
  final Json json;

  FirmaCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => FirmaDto.fromJson(e),
        );
  FirmaCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => FirmaDto.fromJson(e),
        );

  @override
  FirmaCollection collection() {
    return FirmaCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
