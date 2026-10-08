import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/model/get_customer_model.dart';
import 'customer_collection_dto.dart';

final class GetCustomerDto extends JsonDto<GetCustomerModel> {
  final Json json;

  GetCustomerDto.fromJson(this.json) : super.fromJson(json);

  String get next => json["next"] ?? "";

  String get previous => json["previous"] ?? "";

  int get total => json.integer("total");

  CustomerCollectionDto get data => CustomerCollectionDto.fromList(
        json["data"] ?? [],
      );

  @override
  GetCustomerModel model() {
    return GetCustomerModel(
      next: next,
      previous: previous,
      total: total,
      data: data.collection(),
    );
  }
}
