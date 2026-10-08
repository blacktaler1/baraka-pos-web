import 'package:baraka_pos/shared/presentation/widgets/barcode_scanner_sheet.dart';
import 'package:baraka_pos/features/cash/presentation/widgets/product_card.dart';
import 'package:baraka_pos/features/cash/presentation/widgets/search_input_widget.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/cash_product_bloc/cash_product_bloc.dart';

class CashProductsSection extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final FocusNode scannerFocusNode;
  final void Function(String) onSearchChange;
  final ValueChanged<String>? onScan;

  const CashProductsSection({
    super.key,
    required this.searchController,
    required this.searchFocusNode,
    required this.scannerFocusNode,
    required this.onSearchChange,
    this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (context.isMobile)
          Row(
            children: [
              Expanded(
                child: SearchInputWidget(
                  searchFocusNode: searchFocusNode,
                  searchController: searchController,
                  onChanged: onSearchChange,
                  width: double.infinity,
                ),
              ),
              if (onScan != null) ...[
                const SizedBox(width: AppSpacing.xs),
                ScanBarcodeButton(onScanned: onScan!),
              ],
            ],
          )
        else
          AppSectionHeader(
            title: "products".tr(),
            icon: Icons.shopping_bag_rounded,
            trailing: SearchInputWidget(
              searchFocusNode: searchFocusNode,
              searchController: searchController,
              onChanged: onSearchChange,
              onSubmitted: (_) => scannerFocusNode.requestFocus(),
            ),
          ),
        SizedBox(height: context.isMobile ? AppSpacing.sm : AppSpacing.md),
        Expanded(
          child: BlocConsumer<CashProductBloc, CashProductState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (error) => ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error.message))),
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                failure: (error) => AppErrorState(message: error.message),
                success: (model) {
                  if (model.data.models.isEmpty) {
                    return AppCard(
                      child: EmptyState(
                        icon: Icons.search_off_rounded,
                        message: tr("not_item"),
                      ),
                    );
                  }
                  return GridView.builder(
                    itemCount: model.data.models.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 220,
                      mainAxisSpacing:
                          context.isMobile ? AppSpacing.xs : AppSpacing.md,
                      crossAxisSpacing:
                          context.isMobile ? AppSpacing.xs : AppSpacing.md,
                    ),
                    itemBuilder: (context, index) {
                      final product = model.data.models[index];
                      return ProductCard(
                        model: product,
                        onTap: () {
                          searchController.clear();
                          context.push("/cash_register", extra: product);
                        },
                      );
                    },
                  );
                },
                orElse: () => const AppLoading(),
              );
            },
          ),
        ),
      ],
    );
  }
}
