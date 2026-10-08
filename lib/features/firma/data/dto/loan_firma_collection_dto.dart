import 'package:baraka_pos/features/firma/data/data.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/loan_firma_collection.dart';
import '../../domain/model/loan_firma_model.dart';

final class LoanFirmaCollectionDto extends JsonCollectionDto<LoanFirmaDto,
    LoanFirmaCollection, LoanFirmaModel> {
  final Json json;

  LoanFirmaCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => LoanFirmaDto.fromJson(e),
        );

  LoanFirmaCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => LoanFirmaDto.fromJson(e),
        );
  @override
  LoanFirmaCollection collection() {
    return LoanFirmaCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
