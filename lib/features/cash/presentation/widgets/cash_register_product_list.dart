import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/cash_product_model.dart';
import '../../domain/model/mock_order.dart';
import '../blocs/cash_product_bloc/cash_product_bloc.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'product_card.dart';

class CashRegisterProductList extends StatelessWidget {
  final List<MockOrder> mockOrders;
  final MockOrder? selectedOrder;
  final Function(CashProductModel) addToOrder;
  final Function(int) removeFromOrder;
  final bool Function(int) isProductInOrder;
  final Function() loadProductData;

  const CashRegisterProductList({
    super.key,
    required this.mockOrders,
    required this.selectedOrder,
    required this.addToOrder,
    required this.removeFromOrder,
    required this.isProductInOrder,
    required this.loadProductData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<CashProductBloc, CashProductState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (model) {},
            failure: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.message)),
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            failure: (error) => AppErrorState(message: error.message),
            success: (model) {
              if (model.data.models.isEmpty) {
                return AppCard(
                  child: EmptyState(
                    icon: Icons.inventory_2_rounded,
                    message: tr("not_item"),
                  ),
                );
              }
              return GridView.builder(
                itemCount: model.data.models.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 190,
                  mainAxisExtent: 210,
                  mainAxisSpacing: AppSpacing.sm,
                  crossAxisSpacing: AppSpacing.sm,
                ),
                itemBuilder: (context, index) {
                  final e = model.data.models[index];
                  final added = isProductInOrder(e.id);
                  return ProductCard(
                    key: ValueKey(e.id),
                    model: e,
                    selected: added,
                    onTap: () => added ? removeFromOrder(e.id) : addToOrder(e),
                  );
                },
              );
            },
            orElse: () => const AppLoading(),
          );
        },
      ),
    );
  }
}
