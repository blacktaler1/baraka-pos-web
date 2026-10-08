import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/features/store/presentation/blocs/stock_update_bloc/stock_update_bloc.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/blocs/cash_product_bloc/cash_product_bloc.dart';
import '../blocs/all_product_bloc/all_product_bloc.dart';

Future<void> showStockPanel(
  BuildContext context, {
  required ProductModel product,
  required bool add,
  int firmaId = 0,
}) {
  return showAppSidePanel(
    context,
    builder: (_) => ProductAddStockWidget(
      product: product,
      title: add ? 'add' : 'remove',
      firmaId: firmaId,
    ),
  );
}

class ProductSummaryCard extends StatelessWidget {
  final ProductModel product;

  const ProductSummaryCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.imageCollection.models.isNotEmpty
        ? product.imageCollection.models.first.file
        : null;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          AppAvatar(name: product.title, imageUrl: imageUrl, size: 56),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.category.title, style: AppText.caption),
                Text(product.title, style: AppText.h3),
                const SizedBox(height: AppSpacing.xxs),
                Row(
                  children: [
                    Text(
                      formatCurrency(product.price),
                      style: AppText.bodyStrong,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    AppBadge(
                      "${tr("current_stock")}: ${product.stock} ${product.unit}",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductAddStockWidget extends StatefulWidget {
  final ProductModel product;
  final String title;
  final int firmaId;

  const ProductAddStockWidget({
    super.key,
    required this.product,
    required this.title,
    this.firmaId = 0,
  });

  @override
  State<ProductAddStockWidget> createState() => _ProductAddStockWidgetState();
}

class _ProductAddStockWidgetState extends State<ProductAddStockWidget> {
  final amountController = TextEditingController();
  bool isLoad = false;

  bool get _isAdd => widget.title == "add";

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (amountController.text.trim().isEmpty) return;
    setState(() => isLoad = true);
    context.read<StockUpdateBloc>().add(
          StockUpdateEventStarted(
            action: widget.title,
            amount: parseAmount(amountController.text),
            pk: widget.product.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final label = _isAdd ? tr("add_stock") : tr("remove_stock");

    return BlocListener<StockUpdateBloc, StockUpdateState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) {
            setState(() => isLoad = false);
            Navigator.pop(context);
            context.read<AllProductBloc>().add(AllProductEvent(
                  search: '',
                  cursor: '',
                  pageSize: 0,
                  firmaId: widget.firmaId,
                  category: '',
                  lowStock: false,
                ));
            context.read<CashProductBloc>().add(
                  CashProductStarted(
                    search: "",
                    cursor: "",
                    pageSize: "all",
                    category: "",
                  ),
                );
          },
          failure: (error) {
            setState(() => isLoad = false);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.message)));
          },
        );
      },
      child: AppSidePanel(
        title: label,
        icon: _isAdd
            ? Icons.add_box_rounded
            : Icons.indeterminate_check_box_rounded,
        iconColor: _isAdd ? AppColors.success : AppColors.warning,
        subtitle: widget.product.title,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductSummaryCard(product: widget.product),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              label: tr("quantity"),
              required: true,
              hint: tr("enter_quantity"),
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              suffix: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: Center(
                  widthFactor: 1,
                  child: Text(widget.product.unit, style: AppText.small),
                ),
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
        actions: [
          AppButton.secondary(
            label: tr("cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          _isAdd
              ? AppButton(
                  label: label,
                  loading: isLoad,
                  onPressed:
                      amountController.text.trim().isEmpty ? null : _submit,
                )
              : AppButton.danger(
                  label: label,
                  loading: isLoad,
                  onPressed:
                      amountController.text.trim().isEmpty ? null : _submit,
                ),
        ],
      ),
    );
  }
}
