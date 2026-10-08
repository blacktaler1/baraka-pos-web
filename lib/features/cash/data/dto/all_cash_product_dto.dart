import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/model/all_cash_product_model.dart';
import '../../domain/model/cash_product_collection.dart';
import 'cash_product_collection_dto.dart';

final class AllCashProductDto extends JsonDto<AllCashProductModel> {
  final Json json;

  AllCashProductDto.fromJson(this.json) : super.fromJson(json);

  String get next => json['next'] ?? "";

  String get previous => json['previous'] ?? "";

  int get total => json.integer('total');

  CashProductCollection get data {
    final raw = json["data"];
    return CashProductCollectionDto.fromList(raw is List ? raw : [])
        .collection();
  }

  @override
  AllCashProductModel model() {
    return AllCashProductModel(
      next: next,
      previous: previous,
      total: total,
      data: data,
    );
  }
}
