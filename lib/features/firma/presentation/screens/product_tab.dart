import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/widgets/pagination_widget.dart';
import '../../../global/presentation/blocs/get_category_bloc/get_category_bloc.dart';
import '../../../store/presentation/blocs/all_product_bloc/all_product_bloc.dart';
import '../../../store/presentation/blocs/delete_product_bloc/delete_product_bloc.dart';
import '../../../store/presentation/screens/create_product_screen.dart';
import '../../../store/presentation/widgets/products_data_table.dart';

class ProductTab extends StatefulWidget {
  final int firmaId;

  const ProductTab({super.key, required this.firmaId});

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {
  final TextEditingController searchController = TextEditingController();

  int currentPage = 1;
  int rowsPerPage = 10;
  int totalItems = 0;
  String selectedCategoryTitle = "";
  List<String?> cursors = [null];

  void loadProductData({required String cursor}) {
    context.read<AllProductBloc>().add(
          AllProductEvent(
            search: searchController.text,
            cursor: cursor,
            pageSize: rowsPerPage,
            category: selectedCategoryTitle,
            firmaId: widget.firmaId,
            lowStock: false,
          ),
        );
  }

  void _reset() {
    currentPage = 1;
    cursors = [null];
    totalItems = 0;
  }

  void onPageChanged(int page) {
    if (page == currentPage) return;
    setState(() => currentPage = page);
    loadProductData(cursor: cursors[page - 1] ?? "");
  }

  void onRowsPerPageChanged(int value) {
    setState(() {
      rowsPerPage = value;
      _reset();
    });
    loadProductData(cursor: "");
  }

  void onSearchChange(String value) {
    setState(_reset);
    loadProductData(cursor: "");
  }

  void onCategoryChange(String? value) {
    setState(() {
      _reset();
      selectedCategoryTitle = value ?? "";
    });
    loadProductData(cursor: "");
  }

  @override
  void initState() {
    super.initState();
    loadProductData(cursor: "");
    context
        .read<GetCategoryBloc>()
        .add(GetCategoryStarted(cursor: "", pageSize: "all"));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _categoryFilter() {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        final titles = state.maybeWhen(
          success: (model) =>
              model.collection.models.map((e) => e.title).toSet().toList(),
          orElse: () => <String>[],
        );
        return SizedBox(
          width: 220,
          child: AppDropdown<String>(
            hint: tr("category"),
            value: titles.contains(selectedCategoryTitle)
                ? selectedCategoryTitle
                : null,
            items: [
              DropdownMenuItem(
                value: "",
                child: Row(
                  children: [
                    const Icon(Icons.apps_rounded,
                        size: 16, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.xs),
                    Text(tr("all_categories")),
                  ],
                ),
              ),
              for (final t in titles)
                DropdownMenuItem(
                  value: t,
                  child: Row(
                    children: [
                      const Icon(Icons.sell_rounded,
                          size: 15, color: AppColors.textTertiary),
                      const SizedBox(width: AppSpacing.xs),
                      Flexible(
                        child: Text(t, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
            ],
            onChanged: onCategoryChange,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteProductBloc, DeleteProductState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) => loadProductData(cursor: ""),
          failure: (error) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message))),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppToolbar(
            leading: [
              AppSearchField(
                hintText: tr("search_product"),
                controller: searchController,
                onChanged: onSearchChange,
              ),
              _categoryFilter(),
            ],
            trailing: [
              AppButton(
                label: tr("add_new"),
                icon: Icons.add_box_rounded,
                onPressed: () =>
                    showCreateProductPanel(context, firmaId: widget.firmaId),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: BlocConsumer<AllProductBloc, AllProductState>(
              listener: (context, state) {
                state.whenOrNull(
                  success: (model) {
                    setState(() {
                      totalItems = model.total;
                      if (model.next.isNotEmpty &&
                          currentPage == cursors.length) {
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
                  initial: () => const SizedBox.shrink(),
                  inPrepare: () => const AppLoading(),
                  failure: (error) => AppErrorState(
                    message: error.toString(),
                    onRetry: () => loadProductData(cursor: ""),
                  ),
                  success: (model) => ProductsDataTable(
                    products: model.collection.models.toList(),
                    firmaId: widget.firmaId,
                  ),
                );
              },
            ),
          ),
          if (totalItems > 0) ...[
            const SizedBox(height: AppSpacing.md),
            PaginationWidget(
              totalItems: totalItems,
              currentPage: currentPage,
              totalPages: (totalItems / rowsPerPage).ceil(),
              rowsPerPage: rowsPerPage,
              onPageChanged: onPageChanged,
              onRowsPerPageChanged: onRowsPerPageChanged,
            ),
          ],
        ],
      ),
    );
  }
}
