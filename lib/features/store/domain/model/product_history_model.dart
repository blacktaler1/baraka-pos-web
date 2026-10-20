import 'package:baraka_pos/shared/domain/domain.dart';

/// Zaxira harakati turi (backend `kind` qiymatlari)
abstract final class StockMovementKind {
  static const initial = 'initial';
  static const add = 'add';
  static const remove = 'remove';
  static const writeOff = 'write_off';
  static const inventoryPlus = 'inv_plus';
  static const inventoryMinus = 'inv_minus';
  static const sale = 'sale';
  static const refund = 'refund';

  /// Qoldiqni oshiradigan harakatlar
  static const incoming = [initial, add, inventoryPlus, refund];

  static bool isIncoming(String kind) => incoming.contains(kind);
}

/// Tarixdagi bitta yozuv: kirim, chiqim, sotuv yoki vozvrat
final class StockMovementModel extends Model {
  final String id;
  final String kind;
  final double quantity;

  /// Sotuvda: chekdagi asl miqdor (keyin qisman qaytarilgan bo'lsa ham)
  final double? originalQuantity;
  final String price;
  final String total;
  final DateTime? created;
  final String user;
  final String reason;
  final String note;
  final String purchaseType;
  final int? transactionId;

  /// Dona/metrlab sotilgan bo'lsa — dona/metrdagi miqdor
  final double? pieceQuantity;

  const StockMovementModel({
    required this.id,
    required this.kind,
    required this.quantity,
    required this.originalQuantity,
    required this.price,
    required this.total,
    required this.created,
    required this.user,
    required this.reason,
    required this.note,
    required this.purchaseType,
    required this.transactionId,
    required this.pieceQuantity,
  });

  bool get isIncoming => StockMovementKind.isIncoming(kind);

  @override
  List<String> get props => [
        "id: $id",
        "kind: $kind",
        "quantity: $quantity",
        "created: $created",
      ];
}

/// Davr bo'yicha jami miqdorlar
final class StockSummaryModel extends Model {
  final double initial;
  final double added;
  final double removed;
  final double writtenOff;
  final double inventoryPlus;
  final double inventoryMinus;

  /// Vozvratlardan keyingi sof sotuv
  final double sold;
  final double refunded;

  const StockSummaryModel({
    required this.initial,
    required this.added,
    required this.removed,
    required this.writtenOff,
    required this.inventoryPlus,
    required this.inventoryMinus,
    required this.sold,
    required this.refunded,
  });

  double get totalIn => initial + added + inventoryPlus;
  double get totalOut => removed + writtenOff + inventoryMinus;

  @override
  List<String> get props => [
        "totalIn: $totalIn",
        "totalOut: $totalOut",
        "sold: $sold",
        "refunded: $refunded",
      ];
}

final class ProductHistoryModel extends Model {
  final StockSummaryModel summary;
  final List<StockMovementModel> movements;
  final int count;
  final bool hasMore;

  const ProductHistoryModel({
    required this.summary,
    required this.movements,
    required this.count,
    required this.hasMore,
  });

  @override
  List<String> get props => [
        "summary: $summary",
        "movements: $movements",
        "count: $count",
        "hasMore: $hasMore",
      ];
}
