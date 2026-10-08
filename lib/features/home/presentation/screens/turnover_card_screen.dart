import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/widgets/pagination_widget.dart';
import '../../home.dart';
import 'package:baraka_pos/shared/design/design.dart';

class TurnoverDetailScreen extends StatefulWidget {
  final String period;

  const TurnoverDetailScreen({super.key, required this.period});

  @override
  State<TurnoverDetailScreen> createState() => _TurnoverDetailScreenState();
}

class _TurnoverDetailScreenState extends State<TurnoverDetailScreen> {
  late String _currentPeriod;
  int currentPage = 1;
  int rowsPerPage = 10;
  int totalItems = 0;
  List<String?> cursors = [null];

  void loadProductData({required String cursor}) {
    context.read<GetTurnoverBloc>().add(GetTurnoverEvent(
          period: _currentPeriod,
          cursor: cursor,
          pageSize: rowsPerPage,
        ));
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

  @override
  void initState() {
    super.initState();
    _currentPeriod = widget.period;
    loadProductData(cursor: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPage(
        toolbar: PeriodToolbar(
          title: tr("turnover"),
          icon: Icons.storefront_rounded,
          period: _currentPeriod,
          onPeriodChanged: (p) {
            setState(() {
              _currentPeriod = p;
              currentPage = 1;
              cursors = [null];
            });
            loadProductData(cursor: "");
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
        child: BlocConsumer<GetTurnoverBloc, GetTurnoverState>(
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
              initial: () => const AppLoading(),
              inPrepare: () => const AppLoading(),
              failure: (error) => AppErrorState(
                message: error.toString(),
                onRetry: () => loadProductData(cursor: ""),
              ),
              success: (model) => PeriodTransactionsTable(
                transactions: model.data.models.toList(),
                showProfit: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
