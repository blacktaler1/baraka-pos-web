import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';

import '../../domain/model/cash_product_model.dart';

class ProductCard extends StatefulWidget {
  final CashProductModel? model;
  final VoidCallback? onTap;
  final bool selected;

  const ProductCard({
    super.key,
    required this.model,
    required this.onTap,
    this.selected = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.model!;
    final selected = widget.selected;
    final stock = double.tryParse(p.stock) ?? 0;
    final stockText =
        stock == stock.roundToDouble() ? stock.toInt().toString() : "$stock";
    final outOfStock = stock <= 0;

    final fallback = Image.asset(
      "assets/images/product_image.jpg",
      fit: BoxFit.cover,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: selected
                  ? AppColors.primary
                  : (_hovered ? AppColors.borderStrong : AppColors.border),
              width: selected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.ink.withValues(alpha: 0.10)
                    : AppColors.shadow,
                blurRadius: _hovered ? 20 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Rasm + ustidagi belgilar
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: ColoredBox(
                        color: AppColors.surfaceMuted,
                        child: p.images.isEmpty
                            ? fallback
                            : Image.network(
                                p.images,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => fallback,
                              ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: _StockBadge(
                        text: "$stockText ${p.unit}",
                        out: outOfStock,
                      ),
                    ),
                    if (selected)
                      const Positioned(
                        top: 6,
                        right: 6,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 8, 2, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.unit == "pack" ? "${p.title} (${p.packSize})" : p.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyStrong,
                    ),
                    Text(
                      p.categoryTitle.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption
                          .copyWith(color: AppColors.textTertiary),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              formatCurrency(p.price, withCurrency: false),
                              style: AppText.h3.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: selected || _hovered
                                ? AppColors.primary
                                : AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Icon(
                            selected
                                ? Icons.remove_rounded
                                : Icons.add_shopping_cart_rounded,
                            size: 15,
                            color: selected || _hovered
                                ? Colors.white
                                : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  final String text;
  final bool out;

  const _StockBadge({required this.text, required this.out});

  @override
  Widget build(BuildContext context) {
    final color = out ? AppColors.danger : AppColors.ink;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: out
            ? AppColors.dangerSoft
            : AppColors.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: AppColors.shadow, blurRadius: 4),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            out
                ? Icons.remove_shopping_cart_rounded
                : Icons.inventory_2_rounded,
            size: 11,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppText.caption.copyWith(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
