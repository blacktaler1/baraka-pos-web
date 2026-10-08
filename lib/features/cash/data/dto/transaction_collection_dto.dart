import 'package:baraka_pos/features/cash/data/dto/transaction_dto.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/transaction_collection.dart';
import '../../domain/model/transaction_model.dart';

final class TransactionCollectionDto extends JsonCollectionDto<TransactionDto,
    TransactionCollection, TransactionModel> {
  final Json json;

  TransactionCollectionDto.fromJson(this.json)
      : super.fromJson(json, (e) => TransactionDto.fromJson(e));

  TransactionCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => TransactionDto.fromJson(e),
        );

  @override
  TransactionCollection collection() {
    return TransactionCollection(models: items.map((e) => e.model()).toList());
  }
}
