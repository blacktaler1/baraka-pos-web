import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class ProductHistoryDto extends JsonDto<ProductHistoryModel> {
  final Json json;

  ProductHistoryDto.fromJson(this.json) : super.fromJson(json);

  static double? _optional(Json json, String key) =>
      json[key] == null ? null : json.decimal(key);

  StockMovementModel _movement(Json m) => StockMovementModel(
        id: m.text('id'),
        kind: m.text('kind'),
        quantity: m.decimal('quantity'),
        originalQuantity: _optional(m, 'original_quantity'),
        price: m.text('price', fallback: '0'),
        total: m.text('total', fallback: '0'),
        created: DateTime.tryParse(m.text('created'))?.toLocal(),
        user: m.text('user'),
        reason: m.text('reason'),
        note: m.text('note'),
        purchaseType: m.text('purchase_type'),
        transactionId: m['transaction_id'] == null ? null : m.integer('transaction_id'),
        pieceQuantity: _optional(m, 'piece_quantity'),
      );

  @override
  ProductHistoryModel model() {
    final s = json.object('summary');
    return ProductHistoryModel(
      summary: StockSummaryModel(
        initial: s.decimal('initial'),
        added: s.decimal('added'),
        removed: s.decimal('removed'),
        writtenOff: s.decimal('written_off'),
        inventoryPlus: s.decimal('inventory_plus'),
        inventoryMinus: s.decimal('inventory_minus'),
        sold: s.decimal('sold'),
        refunded: s.decimal('refunded'),
      ),
      movements: [
        for (final m in json.items('results').whereType<Json>()) _movement(m),
      ],
      count: json.integer('count'),
      hasMore: json.flag('has_more'),
    );
  }
}
