import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/delete_product_bloc/delete_product_bloc.dart';
import 'edit_product_widget.dart';
import 'print_barcode.dart';
import 'product_add_sctock_widget.dart';

class ProductActionsMenu extends StatelessWidget {
  final ProductModel product;
  final int firmaId;

  const ProductActionsMenu({
    super.key,
    required this.product,
    this.firmaId = 0,
  });

  Future<void> _delete(BuildContext context) async {
    final confirmed = await showAppConfirm(
      context,
      title: tr("delete_product"),
      message: "${tr("are_you_sure")} '${product.title}'",
      confirmLabel: tr("yes_delete"),
      danger: true,
    );
    if (confirmed && context.mounted) {
      context.read<DeleteProductBloc>().add(DeleteProductEvent(id: product.id));
    }
  }

  PopupMenuItem<String> _item(String value, IconData icon, String label,
      {Color color = AppColors.primary, Color? textColor}) {
    return PopupMenuItem<String>(
      value: value,
      height: AppSizes.controlHeight,
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 17, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style:
                AppText.bodyMedium.copyWith(color: textColor ?? AppColors.ink),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: tr("actions"),
      color: AppColors.surface,
      elevation: 8,
      shadowColor: AppColors.ink.withValues(alpha: 0.18),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(color: AppColors.border),
      ),
      icon: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.surfaceSunken,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: const Icon(
          Icons.more_vert_rounded,
          color: AppColors.textSecondary,
          size: 18,
        ),
      ),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            showEditProductPanel(context, product: product, firmaId: firmaId);
          case 'add_stock':
            showStockPanel(context,
                product: product, add: true, firmaId: firmaId);
          case 'remove_stock':
            showStockPanel(context,
                product: product, add: false, firmaId: firmaId);
          case 'print':
            showPrintBarcodePanel(context, product: product);
          case 'delete':
            _delete(context);
        }
      },
      itemBuilder: (context) => [
        _item('edit', Icons.edit_rounded, tr("edit"), color: AppColors.info),
        _item('add_stock', Icons.add_box_rounded, tr("add_stock"),
            color: AppColors.success),
        _item('remove_stock', Icons.indeterminate_check_box_rounded,
            tr("remove_stock"),
            color: AppColors.warning),
        _item('print', Icons.qr_code_scanner_rounded, tr("print_barcode"),
            color: AppColors.textSecondary),
        const PopupMenuDivider(),
        _item('delete', Icons.delete_rounded, tr("delete"),
            color: AppColors.danger, textColor: AppColors.danger),
      ],
    );
  }
}
