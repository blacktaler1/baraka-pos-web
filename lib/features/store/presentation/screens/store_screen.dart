import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../../cash/presentation/widgets/pagination_widget.dart';
import '../presentation.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int rowsPerPage = 10;
  int totalItems = 0;
  List<String?> cursors = [null];
  String totalStockValue = "";
  bool lowStockOnly = false;

  void loadProductData({required String cursor}) {
    context.read<AllProductBloc>().add(
          AllProductEvent(
            search: searchController.text,
            cursor: cursor,
            pageSize: rowsPerPage,
            category: "",
            firmaId: 0,
            lowStock: lowStockOnly,
          ),
        );
  }

  void onPageChanged(int page) {
    if (page == currentPage) return;
    setState(() => currentPage = page);
    final String cursorToUse = cursors[page - 1] ?? "";
    loadProductData(cursor: cursorToUse);
  }

  void onRowsPerPageChanged(int value) {
    setState(() {
      rowsPerPage = value;
      currentPage = 1;
      cursors = [null];
      totalItems = 0;
    });
    loadProductData(cursor: "");
  }

  void onSearchChange(String value) {
    setState(() {
      currentPage = 1;
      cursors = [null];
      totalItems = 0;
    });
    loadProductData(cursor: "");
  }

  @override
  void initState() {
    loadProductData(cursor: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteProductBloc, DeleteProductState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) =>
              loadProductData(cursor: cursors[currentPage - 1] ?? ""),
          failure: (error) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message))),
        );
      },
      child: AppPage(
        toolbar: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            SizedBox(height: context.isMobile ? AppSpacing.sm : AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _StoreStatTile(
                    icon: Icons.inventory_2_rounded,
                    color: AppColors.primary,
                    label: tr("total_products"),
                    value: totalStockValue.isEmpty ? null : "$totalItems",
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _StoreStatTile(
                    icon: Icons.account_balance_wallet_rounded,
                    color: AppColors.info,
                    label: "totalStockValue".tr(),
                    value: totalStockValue.isEmpty
                        ? null
                        : formatCurrency(totalStockValue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppToolbar(
              leading: [
                AppSearchField(
                  hintText: tr("search_product"),
                  controller: searchController,
                  onChanged: onSearchChange,
                ),
                AppSegmentedControl<bool>(
                  segments: {
                    false: tr("filter_all"),
                    true: tr("stock_low"),
                  },
                  value: lowStockOnly,
                  onChanged: (v) {
                    if (v == lowStockOnly) return;
                    lowStockOnly = v;
                    onSearchChange(searchController.text);
                  },
                ),
              ],
            ),
          ],
        ),
        footer: totalItems > 0
            ? PaginationWidget(
                totalItems: totalItems,
                currentPage: currentPage,
                totalPages: (totalItems / rowsPerPage).ceil(),
                rowsPerPage: rowsPerPage,
                onPageChanged: onPageChanged,
                onRowsPerPageChanged: onRowsPerPageChanged,
              )
            : null,
        child: BlocConsumer<AllProductBloc, AllProductState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (model) {
                setState(() {
                  totalStockValue =
                      double.parse(model.totalStockValue.toString())
                          .toStringAsFixed(0);
                  totalItems = model.total;
                  if (model.next.isNotEmpty && currentPage == cursors.length) {
                    cursors.add(model.next);
                  }
                });
              },
              failure: (error) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.message))),
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const AppLoading(),
              inPrepare: () => const AppLoading(),
              failure: (error) => AppErrorState(
                message: error.message,
                onRetry: () => loadProductData(cursor: ""),
              ),
              success: (model) =>
                  ProductsDataTable(products: model.collection.models.toList()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (context.isMobile) {
      return AppPageHeader(
        icon: Icons.warehouse_rounded,
        title: tr("warehouse"),
        subtitle: tr("products"),
        actions: [
          AppButton(
            label: tr("add_new"),
            icon: Icons.add_circle_rounded,
            onPressed: () => showCreateProductPanel(context),
          ),
          ProductExcelActions(onImported: () => onSearchChange("")),
        ],
      );
    }
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.warehouse_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr("warehouse"), style: AppText.h1),
              Text(
                tr("products"),
                style: AppText.caption.copyWith(color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
        ProductExcelActions(onImported: () => onSearchChange("")),
        const SizedBox(width: AppSpacing.sm),
        AppButton(
          label: tr("add_new"),
          icon: Icons.add_circle_rounded,
          onPressed: () => showCreateProductPanel(context),
        ),
      ],
    );
  }
}

class _StoreStatTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  /// null — hali yuklanmoqda
  final String? value;

  const _StoreStatTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.16),
                  color.withValues(alpha: 0.06),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.12)),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.small,
                ),
                const SizedBox(height: 2),
                value == null
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(value!, style: AppText.h2),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
