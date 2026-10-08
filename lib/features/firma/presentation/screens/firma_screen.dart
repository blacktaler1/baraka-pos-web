import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/widgets/pagination_widget.dart';
import '../blocs/get_firma_bloc/get_firma_bloc.dart';
import '../widgets/firma_card.dart';
import 'create_firma_screen.dart';

class FirmaScreen extends StatefulWidget {
  const FirmaScreen({super.key});

  @override
  State<FirmaScreen> createState() => _FirmaScreenState();
}

class _FirmaScreenState extends State<FirmaScreen> {
  final TextEditingController searchController = TextEditingController();

  int currentPage = 1;
  int rowsPerPage = 10;
  int totalItems = 0;

  List<String?> cursors = [null];

  @override
  void initState() {
    _loadFirmaData(cursor: "");
    super.initState();
  }

  void _loadFirmaData({required String cursor}) {
    context.read<GetFirmaBloc>().add(
          GetFirmaStarted(
            search: searchController.text,
            cursor: cursor,
            pageSize: rowsPerPage,
            debt: false,
          ),
        );
  }

  void onPageChanged(int page) {
    if (page == currentPage) return;

    setState(() => currentPage = page);

    final String cursorToUse = cursors[page - 1] ?? "";

    _loadFirmaData(cursor: cursorToUse);
  }

  void onRowsPerPageChanged(int value) {
    setState(() {
      rowsPerPage = value;
      currentPage = 1;
      cursors = [null];
      totalItems = 0;
    });

    _loadFirmaData(cursor: "");
  }

  void onSearchChange(String value) {
    setState(() {
      currentPage = 1;
      cursors = [null];
      totalItems = 0;
    });
    _loadFirmaData(cursor: "");
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      toolbar: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppPageHeader(
            icon: Icons.local_shipping_rounded,
            title: tr("company"),
            subtitle: tr("firms_count", args: ["$totalItems"]),
            actions: [
              AppButton(
                label: tr("add_new"),
                icon: Icons.add_business_rounded,
                onPressed: () => showFirmaPanel(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppToolbar(
            leading: [
              AppSearchField(
                controller: searchController,
                onChanged: onSearchChange,
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
      child: BlocConsumer<GetFirmaBloc, GetFirmaState>(
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
            failure: (error) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.message)),
            ),
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            failure: (error) => AppErrorState(
              message: error.message,
              onRetry: () => _loadFirmaData(cursor: ""),
            ),
            success: (model) {
              if (model.results.models.isEmpty) {
                return AppCard(
                  child: EmptyState(
                    icon: Icons.domain_disabled_rounded,
                    message: tr("not_found"),
                  ),
                );
              }
              return GridView.builder(
                itemCount: model.results.models.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 280,
                  mainAxisExtent: 200,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                ),
                itemBuilder: (context, index) =>
                    FirmaCard(model: model.results.models[index]),
              );
            },
            orElse: () => const AppLoading(),
          );
        },
      ),
    );
  }
}
