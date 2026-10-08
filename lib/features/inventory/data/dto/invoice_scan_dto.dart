import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../cash/data/dto/cash_product_dto.dart';
import '../../domain/domain.dart';

final class InvoiceScanDto extends JsonDto<InvoiceScanModel> {
  final Json json;

  const InvoiceScanDto.fromJson(this.json) : super.fromJson(json);

  static InvoiceScanLineModel _line(Json line) {
    final product = line.object("product");
    return InvoiceScanLineModel(
      name: line.text("name"),
      barcode: line.text("barcode"),
      unit: line.text("unit"),
      quantity: line.decimal("quantity"),
      unitCost: line.decimal("unit_cost"),
      lineTotal: line.decimal("line_total"),
      score: line.decimal("score"),
      product:
          product.isEmpty ? null : CashProductDto.fromJson(product).model(),
      candidates: [
        for (final c in line.items("candidates"))
          if (c is Json) CashProductDto.fromJson(c.object("product")).model(),
      ],
    );
  }

  @override
  InvoiceScanModel model() {
    final firma = json.object("firma");
    return InvoiceScanModel(
      supplierName: json.text("supplier_name"),
      invoiceNumber: json.text("invoice_number"),
      invoiceDate: json.text("invoice_date"),
      documentTotal: json.decimal("document_total"),
      firmaId: firma.integer("id"),
      firmaTitle: firma.text("title"),
      lines: [
        for (final line in json.items("lines"))
          if (line is Json) _line(line),
      ],
    );
  }
}
