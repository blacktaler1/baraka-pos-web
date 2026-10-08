import 'dart:async';

import 'package:collection/collection.dart';
import 'package:baraka_pos/features/cash/cash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/presentation/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:baraka_pos/shared/presentation/widgets/barcode_scanner_sheet.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:go_router/go_router.dart';

class CashRegisterScreen extends StatefulWidget {
  final CashProductModel? initialProduct;

  const CashRegisterScreen({
    super.key,
    this.initialProduct,
  });

  @override
  State<CashRegisterScreen> createState() => _CashRegisterScreenState();
}

class _CashRegisterScreenState extends State<CashRegisterScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = '';
  final FocusNode _scannerFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();
  String _barcodeBuffer = "";
  Timer? _debounce;
  bool _customerError = false;
  bool _deadlineError = false;
  late TextEditingController paidAmountController;
  // Telefon: false — mahsulotlar, true — savat
  bool _showCart = false;

  @override
  void initState() {
    super.initState();
    loadProductData();
    context
        .read<GetCategoryBloc>()
        .add(GetCategoryStarted(cursor: '', pageSize: 'all'));
    paidAmountController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialProduct != null) {
        if (double.parse(widget.initialProduct!.stock) != 0) {
          if (double.parse(widget.initialProduct!.stock) < 1 &&
              widget.initialProduct?.unit == "dona") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      "${widget.initialProduct!.title} ${tr('out_of_stock')}")),
            );
          } else {
            context
                .read<CartBloc>()
                .add(AddProductToOrderEvent(widget.initialProduct!));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "${widget.initialProduct!.title} ${tr('out_of_stock')}")),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scannerFocusNode.dispose();
    paidAmountController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _handleBarcodeScan(BuildContext context, KeyEvent event) {
    final FocusNode? focusedChild = FocusScope.of(context).focusedChild;
    final bool isOtherInputFocused =
        focusedChild != null && focusedChild != _scannerFocusNode;
    if (isOtherInputFocused) return;
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (_barcodeBuffer.isNotEmpty) {
          _findLocalProduct(context, _barcodeBuffer);
          _barcodeBuffer = "";
        }
      } else {
        final char = event.character;
        if (char != null) {
          _barcodeBuffer += char;
        }
      }
    }
  }

  void _findLocalProduct(BuildContext context, String barcode) {
    final cleanBarcode = barcode.trim();
    final state = context.read<CashProductBloc>().state;

    state.maybeWhen(
      success: (model) {
        final product = model.data.models.firstWhereOrNull(
          (e) => e.qrcode.toString().trim() == cleanBarcode,
        );
        if (product != null) {
          if (double.parse(product.stock) != 0) {
            if (double.parse(product.stock) < 1 && product.unit == "dona") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("${product.title} ${tr('out_of_stock')}")),
              );
            } else {
              context.read<CartBloc>().add(AddProductToOrderEvent(product));
              SystemSound.play(SystemSoundType.alert);
              if (product.stock.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${product.title} ${tr("add_cassa")}"),
                    backgroundColor: AppColors.success,
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${product.title} ${tr('out_of_stock')}")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${tr("cassa_not_found")} $cleanBarcode"),
              backgroundColor: AppColors.warning,
            ),
          );
        }
      },
      orElse: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr("cassa_loading"))),
        );
      },
    );
  }

  void loadProductData() {
    context.read<CashProductBloc>().add(
          CashProductStarted(
            search: searchController.text,
            cursor: "",
            pageSize: "all",
            category: selectedCategory,
          ),
        );
  }

  void onCategorySelect(String title) {
    setState(() {
      selectedCategory = title;
    });
    loadProductData();
  }

  void onSearchChange(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      loadProductData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innerContext) {
        return KeyboardListener(
          focusNode: _scannerFocusNode,
          autofocus: true,
          onKeyEvent: (event) => _handleBarcodeScan(innerContext, event),
          child: GestureDetector(
            onTap: () => _scannerFocusNode.requestFocus(),
            child: Scaffold(
              backgroundColor: AppColors.canvas,
              body: BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  final mockOrders = cartState.orders;
                  final selectedOrder = cartState.selectedOrder;
                  final selectedId = cartState.selectedOrderId;
                  final grandTotal = selectedOrder?.grandTotal ?? 0;
                  final lengthItems = selectedOrder?.items.length ?? 0;
                  final selectedPaymentMethod = cartState.selectedPaymentMethod;
                  void onPay() {
                    if (selectedOrder == null || selectedOrder.items.isEmpty) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(tr("no_product_selected")),
                          backgroundColor: AppColors.danger,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      _customerError = false;
                      _deadlineError = false;
                    });

                    if (selectedPaymentMethod == "debt") {
                      bool hasError = false;

                      if (cartState.selectedCustomer == null) {
                        _customerError = true;
                        hasError = true;
                      }

                      if (cartState.debtDeadline == null) {
                        _deadlineError = true;
                        hasError = true;
                      }

                      if (hasError) {
                        setState(() {});
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(tr("fill_required_fields")),
                            backgroundColor: AppColors.danger,
                            duration: Duration(seconds: 2),
                          ),
                        );

                        return;
                      }
                    }

                    String formattedDeadline = "";
                    if (selectedPaymentMethod == "debt" &&
                        cartState.debtDeadline != null) {
                      formattedDeadline = DateFormat('yyyy-MM-dd')
                          .format(cartState.debtDeadline!);
                    }
                    final payload = CreateTransactionPayload(
                      customer: selectedPaymentMethod == "debt"
                          ? (cartState.selectedCustomer?.id ?? 0)
                          : 0,
                      deadline: selectedPaymentMethod == "debt"
                          ? formattedDeadline
                          : "",
                      description: selectedPaymentMethod == "debt"
                          ? cartState.debtComment
                          : "",
                      discount: selectedOrder.discountAmount.round(),
                      paidAmount: selectedPaymentMethod == "debt"
                          ? (int.tryParse(cartState.paidAmount) ?? 0)
                          : 0,
                      paymentMethod: selectedPaymentMethod,
                      items: CreateItemCollection(
                        models: selectedOrder.items
                            .map(
                              (item) => CreateItemModel(
                                productId: item.productId,
                                quantity: item.quantity.toString(),
                                isPiece: item.isPieceSale,
                                price: int.parse(
                                  double.parse(item.price).toStringAsFixed(0),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                    context.read<CreateTransactionBloc>().add(
                          CreateTransactionStarted(
                            paymentMethod: payload.paymentMethod,
                            customer: payload.customer,
                            paidAmount: payload.paidAmount,
                            deadline: payload.deadline,
                            description: payload.description,
                            discount: payload.discount,
                            items: payload.items,
                          ),
                        );
                  }

                  final left = CashRegisterLeftCard(
                    searchController: searchController,
                    searchFocusNode: searchFocusNode,
                    selectedCategory: selectedCategory,
                    onCategorySelect: onCategorySelect,
                    onSearchChange: onSearchChange,
                    loadProductData: loadProductData,
                    mockOrders: mockOrders,
                    selectedOrder: selectedOrder,
                  );
                  final right = CashRegisterRightCard(
                    mockOrders: mockOrders,
                    selectedId: selectedId,
                    selectedOrder: selectedOrder,
                    cartState: cartState,
                    grandTotal: grandTotal,
                    lengthItems: lengthItems,
                    selectedPaymentMethod: selectedPaymentMethod,
                    customerError: _customerError,
                    deadlineError: _deadlineError,
                    paidAmountController: paidAmountController,
                    onReset: () {
                      context.read<CartBloc>().add(ResetOrderEvent());
                    },
                    onValidateDebt: () {
                      setState(() {
                        _customerError = false;
                        _deadlineError = false;
                      });
                    },
                    onPay: onPay,
                    onShowCustomerDialog: (ctx) => showCustomerDialog(ctx),
                  );

                  if (context.isMobile) {
                    return _MobileRegisterLayout(
                      showCart: _showCart,
                      onShowCart: (v) => setState(() => _showCart = v),
                      itemCount: lengthItems,
                      grandTotal: grandTotal,
                      onScan: (code) => _findLocalProduct(innerContext, code),
                      products: left,
                      cart: right,
                    );
                  }

                  return Row(children: [left, right]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Telefon uchun kassa: yuqorida tablar, pastda savat summasi
class _MobileRegisterLayout extends StatelessWidget {
  final bool showCart;
  final ValueChanged<bool> onShowCart;
  final int itemCount;
  final double grandTotal;
  final ValueChanged<String> onScan;
  final Widget products;
  final Widget cart;

  const _MobileRegisterLayout({
    required this.showCart,
    required this.onShowCart,
    required this.itemCount,
    required this.grandTotal,
    required this.onScan,
    required this.products,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    final total = formatCurrency(grandTotal.toStringAsFixed(0));
    return Column(
      children: [
        Container(
          color: AppColors.surface,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.xs,
                AppSpacing.sm,
                AppSpacing.xs,
              ),
              child: Row(
                children: [
                  AppBackButton(
                    tooltip: tr("back_to_cash"),
                    onTap: () =>
                        context.canPop() ? context.pop() : context.go("/cash"),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Container(
                      height: AppSizes.controlHeight,
                      padding: const EdgeInsets.all(AppSpacing.xxs),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSunken,
                        borderRadius: AppRadius.control,
                      ),
                      child: Row(
                        children: [
                          _tab(
                            label: tr("products"),
                            icon: Icons.grid_view_rounded,
                            active: !showCart,
                            onTap: () => onShowCart(false),
                          ),
                          _tab(
                            label: tr("cart"),
                            icon: Icons.shopping_cart_rounded,
                            active: showCart,
                            badge: itemCount,
                            onTap: () => onShowCart(true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  ScanBarcodeButton(onScanned: onScan, continuous: true),
                ],
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        if (showCart) cart else products,
        if (!showCart)
          Material(
            color: AppColors.primary,
            child: InkWell(
              onTap: () => onShowCart(true),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "$itemCount",
                          style:
                              AppText.bodyStrong.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          total,
                          style: AppText.h3.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        tr("cart"),
                        style: AppText.bodyStrong.copyWith(color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded,
                          color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _tab({
    required String label,
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
    int badge = 0,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: active
                ? const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 16,
                  color: active ? AppColors.primary : AppColors.textSecondary),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.label.copyWith(
                    color: active ? AppColors.ink : AppColors.textSecondary,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (badge > 0) ...[
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$badge",
                    style: AppText.caption.copyWith(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
