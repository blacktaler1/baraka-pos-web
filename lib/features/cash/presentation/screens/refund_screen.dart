import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefundScreen extends StatefulWidget {
  const RefundScreen({super.key});

  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int rowsPerPage = 10;
  int totalItems = 0;
  List<String?> cursors = [null];

  DateTime? selectedFrom;
  DateTime? selectedTo;

  void loadRefundData({required String cursor}) {
    final fromStr = selectedFrom != null
        ? DateFormat('yyyy-MM-dd').format(selectedFrom!)
        : "";
    final toStr =
        selectedTo != null ? DateFormat('yyyy-MM-dd').format(selectedTo!) : "";

    context.read<GetRefundBloc>().add(GetRefundStarted(
          from: fromStr,
          to: toStr,
          search: searchController.text,
          cursor: cursor,
          pageSize: rowsPerPage,
        ));
  }

  void resetAllFilters() {
    setState(() {
      searchController.clear();
      selectedFrom = null;
      selectedTo = null;
      currentPage = 1;
      cursors = [null];
    });
    loadRefundData(cursor: "");
  }

  void onPageChanged(int page) {
    if (page == currentPage) return;

    setState(() => currentPage = page);

    final String cursorToUse = cursors[page - 1] ?? "";

    loadRefundData(cursor: cursorToUse);
  }

  void onRowsPerPageChanged(int value) {
    setState(() {
      rowsPerPage = value;
      currentPage = 1;
      cursors = [null];
      totalItems = 0;
    });

    loadRefundData(cursor: "");
  }

  void onSearchChange(String value) {
    setState(() {
      currentPage = 1;
      cursors = [null];
      totalItems = 0;
    });
    loadRefundData(cursor: "");
  }

  @override
  void initState() {
    loadRefundData(cursor: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      toolbar: TransactionSearchFilter(
        title: tr("return_history"),
        icon: Icons.assignment_return_rounded,
        searchController: searchController,
        onSearchChange: onSearchChange,
        selectedFrom: selectedFrom,
        selectedTo: selectedTo,
        onDateRangeSelected: (start, end) {
          setState(() {
            selectedFrom = start;
            selectedTo = end;
            currentPage = 1;
            cursors = [null];
          });
          loadRefundData(cursor: "");
        },
        onReset: resetAllFilters,
        onRefresh: () {
          searchController.clear();
          loadRefundData(cursor: "");
        },
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
      child: BlocConsumer<GetRefundBloc, GetRefundState>(
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
              onRetry: () => loadRefundData(cursor: ""),
            ),
            success: (model) {
              final items = model.data.models;
              if (items.isEmpty) {
                return AppCard(
                  child: EmptyState(
                    icon: Icons.receipt_long_rounded,
                    message: tr("not_found"),
                  ),
                );
              }
              return AppDataTable(
                columns: [
                  tr("refund_id"),
                  tr("real_buy_id"),
                  tr("date"),
                  tr("product_names"),
                  tr("reason"),
                  tr("quantity"),
                  tr("price"),
                  ""
                ],
                numericColumns: const {5, 6},
                rows: items.map(_row).toList(),
              );
            },
          );
        },
      ),
    );
  }

  String _date(String? created) {
    final createdAt = DateTime.tryParse(created ?? '');
    if (createdAt == null) return '';
    return DateFormat('dd.MM.yyyy').format(createdAt.toLocal());
  }

  String _qty(String v) => num.parse(v).toStringAsFixed(0);

  DataRow _row(dynamic t) {
    return DataRow(
      cells: [
        DataCell(Text('${t.id}', style: AppText.small)),
        DataCell(Text(t.transactionId, style: AppText.small)),
        DataCell(Text(_date(t.created), style: AppText.small)),
        DataCell(
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 260),
            child: Text(
              t.items.models.map((e) => e.productTitle).join(", "),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.body,
            ),
          ),
        ),
        DataCell(
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Text(
              t.description.isEmpty ? '-' : t.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.small,
            ),
          ),
        ),
        DataCell(Text(_qty(t.totalNum), style: AppText.body)),
        DataCell(
          Text(
            formatCurrency(t.totalPrice),
            style: AppText.bodyStrong.copyWith(color: AppColors.danger),
          ),
        ),
        DataCell(
          AppIconButton(
            icon: Icons.visibility_rounded,
            tooltip: tr("view_details"),
            onPressed: () => showRefundDetailPanel(context, t),
          ),
        ),
      ],
    );
  }
}
