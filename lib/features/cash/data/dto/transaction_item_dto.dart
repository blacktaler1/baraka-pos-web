import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/transaction_item_model.dart';

final class TransactionItemDto extends JsonDto<TransactionItemModel> {
  final Json json;

  TransactionItemDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer('id');

  int get productId => json.object('product').integer('id');

  String get productTitle => json.object('product').text('title');

  String get productUnit => json.object('product').text('unit');

  num get productPrice => json.object('product').number('price');

  int get packSize => json.integer('pack_size');

  String get quantity => json.text('quantity', fallback: "0");

  String get subtotal => json.text('subtotal', fallback: "0");

  String get status => json.text('status');

  @override
  TransactionItemModel model() {
    return TransactionItemModel(
      id: id,
      productId: productId,
      productTitle: productTitle,
      productUnit: productUnit,
      productPrice: productPrice,
      quantity: quantity,
      subtotal: subtotal,
      status: status,
      packSize: packSize,
    );
  }
}
