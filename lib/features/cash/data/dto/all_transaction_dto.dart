import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class AllTransactionDto extends JsonDto<AllTransactionModel> {
  final Json json;

  const AllTransactionDto.fromJson(this.json) : super.fromJson(json);

  String get next => json.text("next");

  String get previous => json.text("previous");

  int get total => json.integer("total");
  double get grandTotalSum => json.decimal("grand_total_sum");
  double get totalCash => json.decimal("total_cash");
  double get totalCard => json.decimal("total_card");
  double get totalDebt => json.decimal("total_debt");

  TransactionCollection get data {
    final raw = json["data"];
    return TransactionCollectionDto.fromList(raw is List ? raw : [])
        .collection();
  }

  @override
  AllTransactionModel model() {
    return AllTransactionModel(
      next: next,
      previous: previous,
      total: total,
      grandTotalSum: grandTotalSum,
      totalCash: totalCash,
      totalCard: totalCard,
      totalDebt: totalDebt,
      data: data,
    );
  }
}
