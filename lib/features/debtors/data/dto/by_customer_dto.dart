import 'package:baraka_pos/features/debtors/debtors.dart';
import '../../../../shared/shared.dart';

final class ByCustomerDto extends JsonDto<ByCustomerModel> {
  final Json json;

  ByCustomerDto.fromJson(this.json) : super.fromJson(json);

  ByCustomerCollectionDto get debtCollection =>
      ByCustomerCollectionDto.fromList(json["data"]);

  @override
  ByCustomerModel model() {
    return ByCustomerModel(debtCollection: debtCollection.collection());
  }
}
