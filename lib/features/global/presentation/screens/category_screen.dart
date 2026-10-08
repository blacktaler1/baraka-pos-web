import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/widgets/pagination_widget.dart';
import '../../global.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int? selectedIndex;
  int currentPage = 1;
  int rowsPerPage = 10;
  int totalItems = 0;
  List<String?> cursors = [null];

  void loadCategoryData({required String cursor}) {
    context.read<GetCategoryPagBloc>().add(GetCategoryStarted(
          cursor: cursor,
          pageSize: rowsPerPage.toString(),
        ));
  }

  void onPageChanged(int page) {
    if (page == currentPage) return;
    setState(() => currentPage = page);
    final String cursorToUse = cursors[page - 1] ?? "";
    loadCategoryData(cursor: cursorToUse);
  }

  void onRowsPerPageChanged(int value) {
    setState(() {
      rowsPerPage = value;
      currentPage = 1;
      cursors = [null];
      totalItems = 0;
    });
    loadCategoryData(cursor: "");
  }

  @override
  void initState() {
    super.initState();
    loadCategoryData(cursor: "");
  }

  void _reload() => loadCategoryData(cursor: cursors[currentPage - 1] ?? "");

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteCategoryBloc, DeleteCategoryState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) => _reload(),
          failure: (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message)),
          ),
        );
      },
      child: AppPage(
        toolbar: AppPageHeader(
          icon: Icons.category_rounded,
          title: tr("category"),
          subtitle: tr("categories_count", args: ["$totalItems"]),
          actions: [
            AppButton(
              label: tr("add_new"),
              icon: Icons.add_circle_rounded,
              onPressed: () => showCategoryPanel(context),
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
        child: BlocConsumer<GetCategoryPagBloc, GetCategoryState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (model) {
                setState(() {
                  totalItems = model.total;
                  if (model.next.isNotEmpty && currentPage == cursors.length) {
                    cursors.add(model.next);
                  }
                });
              },
              failure: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.message)),
                );
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const AppLoading(),
              inPrepare: () => const AppLoading(),
              failure: (error) => AppErrorState(
                message: error.toString(),
                onRetry: _reload,
              ),
              success: (model) {
                final list = model.collection.models;
                if (list.isEmpty) {
                  return AppCard(
                    child: EmptyState(
                      icon: Icons.dashboard_customize_rounded,
                      message: tr("no_categories"),
                    ),
                  );
                }
                return GridView.builder(
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 240,
                    mainAxisExtent: 196,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                  ),
                  itemBuilder: (context, index) =>
                      CategoryCardWidget(model: list[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
