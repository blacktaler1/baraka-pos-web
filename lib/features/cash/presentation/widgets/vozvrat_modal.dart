import 'package:baraka_pos/features/cash/presentation/widgets/product_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/create_item_collection.dart';
import '../../domain/model/create_item_model.dart';
import '../../domain/model/transaction_model.dart';
import '../blocs/refound_transaction_bloc/refound_transaction_bloc.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> showVozvratPanel(
  BuildContext context, {
  required TransactionModel transaction,
  required VoidCallback onDone,
}) {
  return showAppSidePanel(
    context,
    width: AppSizes.sidePanelWidthWide,
    builder: (_) => VozvratModal(transaction: transaction, loadData: onDone),
  );
}

class VozvratModal extends StatefulWidget {
  final TransactionModel transaction;
  final VoidCallback loadData;

  const VozvratModal(
      {super.key, required this.transaction, required this.loadData});

  @override
  State<VozvratModal> createState() => _VozvratModalState();
}

class _VozvratModalState extends State<VozvratModal> {
  late List<ReturnItem> returnItems;
  final TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    returnItems = widget.transaction.items.models.map((e) {
      return ReturnItem(
        productId: int.parse(e.productId.toString()),
        title: e.productTitle ?? "",
        price: double.tryParse(e.productPrice.toString()) ?? 0,
        quantity: (double.tryParse(e.quantity.toString()) ?? 0),
      );
    }).toList();
  }

  void updateQuantity(int productId, double qty) {
    if (qty < 0) return;
    setState(() {
      final index = returnItems.indexWhere((e) => e.productId == productId);
      if (index != -1) {
        returnItems[index].quantity = qty;
      }
    });
  }

  void deleteItem(int productId) {
    setState(() {
      returnItems.removeWhere((e) => e.productId == productId);
    });
  }

  List<Map<String, dynamic>> buildReturnPayload() {
    final List<Map<String, dynamic>> payload = [];
    for (final originalModel in widget.transaction.items.models) {
      final int id = int.parse(originalModel.productId.toString());
      final double originalQty =
          (double.tryParse(originalModel.quantity.toString()) ?? 0);
      final mockItem = returnItems.where((e) => e.productId == id).firstOrNull;

      if (mockItem == null) {
        payload.add({"product_id": id, "quantity": originalQty.toString()});
      } else {
        final double returnedQty = originalQty - mockItem.quantity;
        if (returnedQty > 0) {
          payload.add({"product_id": id, "quantity": returnedQty.toString()});
        }
      }
    }
    return payload;
  }

  void submitReturn() async {
    final itemsList = buildReturnPayload();

    if (itemsList.isEmpty) {
      return;
    }

    final payloadItems = CreateItemCollection(
      models: itemsList.map((item) {
        return CreateItemModel(
          productId: item["product_id"],
          quantity: item["quantity"],
        );
      }).toList(),
    );

    context.read<RefoundTransactionBloc>().add(
          RefoundTransactionStarted(
            transactionId: widget.transaction.id,
            description: reasonController.text.trim(),
            items: payloadItems,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RefoundTransactionBloc, RefoundTransactionState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(tr("refund_success"))));
            widget.loadData();
            Navigator.pop(context);
          },
          failure: (error) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message))),
        );
      },
      builder: (context, state) {
        final loading =
            state.maybeWhen(inPrepare: () => true, orElse: () => false);
        return AppSidePanel(
          title: tr("return_list"),
          icon: Icons.keyboard_return_rounded,
          iconColor: AppColors.danger,
          subtitle: "${tr("receipt_no")}: #${widget.transaction.transactionId}",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(tr("return_hint"), style: AppText.small),
              const SizedBox(height: AppSpacing.md),
              if (!context.isMobile)
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(tr("product"), style: AppText.caption)),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                        flex: 2,
                        child: Text(tr("price"), style: AppText.caption)),
                    const SizedBox(width: AppSpacing.sm),
                    SizedBox(
                        width: 108,
                        child: Text(tr("quantity"), style: AppText.caption)),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      flex: 2,
                      child: Text(tr("sub_total"),
                          textAlign: TextAlign.right, style: AppText.caption),
                    ),
                    const SizedBox(
                        width: AppSizes.controlHeightSm + AppSpacing.xs),
                  ],
                ),
              const Divider(),
              for (final item in returnItems)
                ProductRow(
                  key: ValueKey("${item.productId}_${item.quantity}"),
                  id: item.productId,
                  title: item.title,
                  stock: widget.transaction.items.models
                      .firstWhere((e) =>
                          int.parse(e.productId.toString()) == item.productId)
                      .quantity
                      .toString(),
                  price: item.price.toString(),
                  quantity: item.quantity,
                  unit: widget.transaction.items.models
                      .firstWhere((e) =>
                          int.parse(e.productId.toString()) == item.productId)
                      .productUnit,
                  onDelete: () => deleteItem(item.productId),
                  updateQuantity: updateQuantity,
                ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                label: tr("reason"),
                hint: tr("enter_reason"),
                controller: reasonController,
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            AppButton.secondary(
              label: tr("cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            AppButton.danger(
              label: tr("do_return"),
              icon: Icons.assignment_return_rounded,
              loading: loading,
              onPressed: submitReturn,
            ),
          ],
        );
      },
    );
  }
}

class ReturnItem {
  final int productId;
  final String title;
  final double price;
  double quantity;

  ReturnItem(
      {required this.productId,
      required this.title,
      required this.price,
      required this.quantity});
}
