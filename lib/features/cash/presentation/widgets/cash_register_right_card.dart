import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cash.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';

import '../../../auth/presentation/screens/splash_screen.dart';
import 'discount_section.dart';

class CashRegisterRightCard extends StatelessWidget {
  final dynamic mockOrders;
  final int selectedId;
  final MockOrder? selectedOrder;
  final CartState cartState;
  final double grandTotal;
  final int lengthItems;
  final String selectedPaymentMethod;

  final bool customerError;
  final bool deadlineError;
  final TextEditingController paidAmountController;

  final VoidCallback onReset;
  final VoidCallback onValidateDebt;
  final VoidCallback onPay;
  final Function(BuildContext) onShowCustomerDialog;

  const CashRegisterRightCard({
    super.key,
    required this.mockOrders,
    required this.selectedId,
    required this.selectedOrder,
    required this.cartState,
    required this.grandTotal,
    required this.lengthItems,
    required this.selectedPaymentMethod,
    required this.customerError,
    required this.deadlineError,
    required this.paidAmountController,
    required this.onReset,
    required this.onValidateDebt,
    required this.onPay,
    required this.onShowCustomerDialog,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final pad = mobile ? AppSpacing.md : AppSpacing.xl;
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: mobile
              ? null
              : const Border(left: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(pad),
              child: OrderListPanel(
                mockOrders: mockOrders,
                selectedId: selectedId,
                addNewOrder: () {
                  if (mockOrders.length < 10) {
                    context.read<CartBloc>().add(AddNewOrderEvent());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("close_old_orders_warning".tr())),
                    );
                  }
                },
                onOrderSelect: (id) =>
                    context.read<CartBloc>().add(SelectOrderEvent(id)),
                onOrderDelete: (id) {
                  context.read<CartBloc>().add(DeleteOrderEvent(id));
                  if (mockOrders.length == 1 &&
                      mockOrders.first.transactionId == id) {
                    context.pop();
                  }
                },
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(pad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (selectedOrder != null)
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("wholesale_prices".tr(),
                            style: AppText.bodyMedium),
                        value: selectedOrder!.wholesale,
                        onChanged: (v) => context
                            .read<CartBloc>()
                            .add(ToggleWholesaleEvent(v)),
                      ),
                    OrderDetailsPanel(
                      selectedOrder: selectedOrder,
                      lengthItems: lengthItems,
                      removeFromOrder: (id) => context
                          .read<CartBloc>()
                          .add(RemoveProductFromOrderEvent(id)),
                      updateItemQuantity: (id, qty) => context
                          .read<CartBloc>()
                          .add(UpdateItemQuantityEvent(id, qty)),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    if (selectedOrder != null &&
                        (globalUser?.canDiscount ?? false)) ...[
                      DiscountSection(
                        key: ValueKey(selectedOrder!.transactionId),
                        order: selectedOrder!,
                        maxPercent: globalUser!.maxDiscountPercent,
                        onChanged: (value, isPercent) => context
                            .read<CartBloc>()
                            .add(UpdateDiscountEvent(
                                value: value, isPercent: isPercent)),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                    PaymentMethodSelector(
                      selectedPaymentMethod: selectedPaymentMethod,
                      onSelect: (method) => context
                          .read<CartBloc>()
                          .add(ChangePaymentMethodEvent(method)),
                    ),
                    if (selectedPaymentMethod == "debt") ...[
                      const SizedBox(height: AppSpacing.md),
                      DebtPaymentSection(
                        cartState: cartState,
                        paidAmountController: paidAmountController,
                        customerError: customerError,
                        deadlineError: deadlineError,
                        onShowCustomerDialog: onShowCustomerDialog,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                pad,
                mobile ? AppSpacing.sm : pad,
                pad,
                (mobile ? AppSpacing.sm : pad) +
                    MediaQuery.paddingOf(context).bottom,
              ),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GrandTotalPanel(
                    grandTotal: grandTotal,
                    subtotal: selectedOrder?.subtotal ?? 0,
                    discount: selectedOrder?.discountAmount ?? 0,
                  ),
                  SizedBox(height: mobile ? AppSpacing.sm : AppSpacing.md),
                  Row(
                    children: [
                      AppButton.secondary(
                        label: mobile ? "" : "reset".tr(),
                        icon: Icons.restart_alt_rounded,
                        onPressed: onReset,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: CashRegisterPay(
                          removeFromOrder: () {
                            if (selectedOrder != null) {
                              context.read<CartBloc>().add(
                                    DeleteOrderEvent(
                                        selectedOrder!.transactionId),
                                  );
                              if (mockOrders.length == 1) context.pop();
                            }
                          },
                          onPressed: onPay,
                          grandTotal:
                              formatCurrency(grandTotal.toStringAsFixed(0)),
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
    );
  }
}
