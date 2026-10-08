import 'package:baraka_pos/features/cash/presentation/widgets/thousands_separator_formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../../auth/presentation/screens/splash_screen.dart';
import '../blocs/cart_bloc/cart_bloc.dart';
import 'package:baraka_pos/shared/design/design.dart';

class ProductRow extends StatefulWidget {
  final int id;
  final String title;
  final String stock;
  final String price;
  final double quantity;
  final String unit;
  final Function() onDelete;
  final bool cash;

  /// "Mavjud" yonidagi yozuv (rulon: "1 dona + 33 m")
  final String? stockLabel;

  /// Nom ostidagi qo'shimcha (rulon: Metr / Dona tanlovi)
  final Widget? modeToggle;

  final Function(int productId, double newQuantity) updateQuantity;

  const ProductRow({
    super.key,
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.onDelete,
    required this.updateQuantity,
    this.cash = false,
    this.stockLabel,
    this.modeToggle,
  });

  @override
  State<ProductRow> createState() => _ProductRowState();
}

class _ProductRowState extends State<ProductRow> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  double subTotal = 0;
  bool get isPieceUnit => widget.unit.toLowerCase() == 'dona';

  /// Metr kasr bo'lishi mumkin (0.5 m), boshqalar kamida 1
  double get _minQty => widget.unit.toLowerCase() == 'metr' ? 0.1 : 1;

  String _fmtQty(double q) {
    if (isPieceUnit) return q.toInt().toString();
    if (q == q.roundToDouble()) return q.toInt().toString();
    return q.toStringAsFixed(2).replaceFirst(RegExp(r'0+$'), '');
  }

  @override
  void initState() {
    super.initState();
    subTotal = double.parse(widget.price) * widget.quantity;
    _priceController.text = formatCurrency(
        int.parse(double.parse(widget.price).toStringAsFixed(0)).toString(),
        withCurrency: false);
    _controller.text = _fmtQty(widget.quantity);
  }

  @override
  void didUpdateWidget(covariant ProductRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity ||
        oldWidget.unit != widget.unit) {
      _controller.text = _fmtQty(widget.quantity);
      subTotal = double.parse(widget.price) * widget.quantity;
    }
    if (oldWidget.price != widget.price) {
      _priceController.text = formatCurrency(
          double.parse(widget.price).toStringAsFixed(0),
          withCurrency: false);
      subTotal = double.parse(widget.price) * widget.quantity;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _applyStockLimit() {
    double qty = double.tryParse(_controller.text) ?? 1;
    final double stock = double.parse(widget.stock);
    if (isPieceUnit) {
      qty = qty.floorToDouble();
    }

    if (qty < _minQty) qty = _minQty;
    if (qty > stock) qty = stock;

    _controller.text = _fmtQty(qty);

    setState(() {
      subTotal = double.parse(widget.price) * qty;
    });

    widget.updateQuantity(widget.id, qty);
  }

  void _step(double delta) {
    setState(() {
      double qty = double.tryParse(_controller.text) ?? 1;
      final double stock = double.parse(widget.stock);
      final next = qty + delta;
      if (next < _minQty || next > stock + 1e-9) return;
      qty = isPieceUnit ? next.floorToDouble() : next;
      _controller.text = _fmtQty(qty);
      subTotal = double.parse(widget.price) * qty;
      widget.updateQuantity(widget.id, qty);
    });
  }

  void _commitPrice(String value) {
    if (value.isEmpty) return;
    final cleaned = value.replaceAll(' ', '');
    context.read<CartBloc>().add(UpdateItemPriceEvent(widget.id, cleaned));
    setState(() {
      subTotal = double.parse(cleaned) * double.parse(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final qty = double.tryParse(_controller.text) ?? 1;
    final stock = double.parse(widget.stock);

    final cells = <Widget>[
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.bodyStrong,
            ),
            Text(
              "${tr("in_stock")}: ${widget.stockLabel ?? (stock == stock.roundToDouble() ? stock.toInt() : stock)}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.caption,
            ),
            if (widget.modeToggle != null) widget.modeToggle!,
          ],
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        flex: 2,
        child: widget.cash && (globalUser?.canEditPrice ?? true)
            ? SizedBox(
                height: AppSizes.controlHeightSm,
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorFormatter(),
                  ],
                  style: AppText.body,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 8,
                    ),
                  ),
                  onSubmitted: _commitPrice,
                  onTapOutside: (_) => _commitPrice(_priceController.text),
                ),
              )
            : Text(
                formatCurrency(widget.price),
                style: AppText.body,
              ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Container(
        height: AppSizes.controlHeightSm,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.surfaceSunken,
          borderRadius: AppRadius.control,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _stepButton(Icons.remove_rounded, qty > 1, () => _step(-1)),
            SizedBox(
              width: 40,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: !isPieceUnit,
                ),
                inputFormatters: [
                  isPieceUnit
                      ? FilteringTextInputFormatter.digitsOnly
                      : FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                ],
                textAlign: TextAlign.center,
                style: AppText.bodyStrong,
                decoration: const InputDecoration(
                  isCollapsed: true,
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  final v = double.tryParse(value);
                  if (v == null) return;
                  final safeQty = v > stock ? stock : v;
                  setState(() {
                    subTotal = double.parse(widget.price) * safeQty;
                  });
                },
                onEditingComplete: _applyStockLimit,
                onTapOutside: (_) => _applyStockLimit(),
              ),
            ),
            _stepButton(Icons.add_rounded, qty < stock, () => _step(1)),
          ],
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        flex: 2,
        child: Text(
          formatCurrency(subTotal.toStringAsFixed(0)),
          textAlign: TextAlign.right,
          style: AppText.bodyStrong,
        ),
      ),
      const SizedBox(width: AppSpacing.xs),
      AppIconButton(
        icon: Icons.close_rounded,
        color: AppColors.textTertiary,
        tooltip: tr("delete"),
        onPressed: widget.onDelete,
      ),
    ];

    if (context.isMobile) {
      // [nomi ............ x]
      // [narx] [- 1 +] [jami]
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [cells[0], cells[8]]),
            const SizedBox(height: AppSpacing.xxs),
            Row(children: [
              cells[2],
              cells[3],
              cells[4],
              cells[5],
              cells[6],
            ]),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(children: cells),
    );
  }

  Widget _stepButton(IconData icon, bool enabled, VoidCallback onTap) {
    return SizedBox.square(
      dimension: 32,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: enabled ? onTap : null,
        icon: Icon(icon, size: 18),
      ),
    );
  }
}
