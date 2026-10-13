/// Qarz cheki uchun ma'lumot: bitta faktura yoki mijozning barcha qarzlari
class DebtReceiptLine {
  final String title;
  final String quantity;
  final num subtotal;

  const DebtReceiptLine({
    required this.title,
    required this.quantity,
    required this.subtotal,
  });
}

class DebtReceiptInvoice {
  final String label;
  final String date;
  final num total;
  final num paid;
  final num remaining;
  final String note;
  final List<DebtReceiptLine> lines;

  const DebtReceiptInvoice({
    required this.label,
    required this.date,
    required this.total,
    required this.paid,
    required this.remaining,
    this.note = "",
    required this.lines,
  });
}

class DebtReceiptData {
  final String customerName;
  final String phone;
  final List<DebtReceiptInvoice> invoices;

  const DebtReceiptData({
    required this.customerName,
    required this.phone,
    required this.invoices,
  });

  num get totalRemaining =>
      invoices.fold<num>(0, (sum, invoice) => sum + invoice.remaining);
}
