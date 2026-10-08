import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:baraka_pos/shared/shared.dart';

final class DebtorsListDto extends JsonDto<DebtorsListModel> {
  final Json json;

  DebtorsListDto.fromJson(this.json) : super.fromJson(json);

  String get next => json.text("next");

  String get previus => json.text("previous");

  int get total => json.integer("total");

  DebtorsCollectionDto get debtorsList => DebtorsCollectionDto.fromList(
        json.items("data"),
      );

  @override
  DebtorsListModel model() {
    return DebtorsListModel(
      next: next,
      previus: previus,
      total: total,
      data: debtorsList.collection(),
    );
  }
}
