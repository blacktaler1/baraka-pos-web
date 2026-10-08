import 'package:baraka_pos/shared/domain/domain.dart';

import '../../../cash/domain/model/cash_product_model.dart';

/// Nakladnoydan AI ajratib olgan bitta qator va unga mos ombor mahsuloti
final class InvoiceScanLineModel extends Model {
  final String name;
  final String barcode;
  final String unit;
  final double quantity;
  final double unitCost;
  final double lineTotal;
  final double score;

  /// Ishonchli moslangan mahsulot; null bo'lsa — foydalanuvchi o'zi tanlaydi
  final CashProductModel? product;
  final List<CashProductModel> candidates;

  const InvoiceScanLineModel({
    required this.name,
    required this.barcode,
    required this.unit,
    required this.quantity,
    required this.unitCost,
    required this.lineTotal,
    required this.score,
    required this.product,
    required this.candidates,
  });

  @override
  List<String> get props => [
        "name: $name",
        "barcode: $barcode",
        "quantity: $quantity",
        "unitCost: $unitCost",
        "product: ${product?.id}",
      ];
}

final class InvoiceScanModel extends Model {
  final String supplierName;
  final String invoiceNumber;
  final String invoiceDate;
  final double documentTotal;
  final int firmaId;
  final String firmaTitle;
  final List<InvoiceScanLineModel> lines;

  const InvoiceScanModel({
    required this.supplierName,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.documentTotal,
    required this.firmaId,
    required this.firmaTitle,
    required this.lines,
  });

  @override
  List<String> get props => [
        "supplierName: $supplierName",
        "invoiceNumber: $invoiceNumber",
        "firmaId: $firmaId",
        "lines: ${lines.length}",
      ];
}
