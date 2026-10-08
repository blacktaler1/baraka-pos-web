import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cash.dart';

class CashRegisterLeftCard extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocusNode;

  final String selectedCategory;
  final Function(String) onCategorySelect;
  final Function(String) onSearchChange;
  final VoidCallback loadProductData;

  final dynamic mockOrders;
  final dynamic selectedOrder;

  const CashRegisterLeftCard({
    super.key,
    required this.searchController,
    required this.searchFocusNode,
    required this.selectedCategory,
    required this.onCategorySelect,
    required this.onSearchChange,
    required this.loadProductData,
    required this.mockOrders,
    required this.selectedOrder,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(mobile ? AppSpacing.sm : AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 Header (Search)
            CashRegisterHeader(
              onSearchChange: onSearchChange,
              onSubmitted: (_) {},
              searchFocusNode: searchFocusNode,
              searchController: searchController,
            ),

            SizedBox(height: mobile ? AppSpacing.sm : AppSpacing.lg),

            /// 📂 Category List
            CashRegisterCategoryList(
              selectedCategory: selectedCategory,
              onCategorySelect: onCategorySelect,
            ),

            SizedBox(height: mobile ? AppSpacing.sm : AppSpacing.lg),

            /// 🛒 Product List
            CashRegisterProductList(
              mockOrders: mockOrders,
              selectedOrder: selectedOrder,

              /// ➕ Add product
              addToOrder: (product) {
                final stock = double.tryParse(product.stock) ?? 0;

                if (stock == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.title} ${tr('out_of_stock')}"),
                    ),
                  );
                  return;
                }

                if (stock < 1 && product.unit == "dona") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.title} ${tr('out_of_stock')}"),
                    ),
                  );
                  return;
                }

                context.read<CartBloc>().add(AddProductToOrderEvent(product));
              },

              /// ❌ Remove product
              removeFromOrder: (productId) {
                context
                    .read<CartBloc>()
                    .add(RemoveProductFromOrderEvent(productId));
              },

              /// ✅ Product order ichidami
              isProductInOrder: (productId) {
                if (selectedOrder == null) return false;
                return selectedOrder!.items
                    .any((e) => e.productId == productId);
              },

              loadProductData: loadProductData,
            ),

            SizedBox(height: mobile ? 0 : 20),
          ],
        ),
      ),
    );
  }
}
