import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/daily_checks_bloc/daily_checks_bloc.dart';
import '../widgets/daily_checks.dart';
import '../widgets/products_table.dart';
import '../widgets/summary_section.dart';

class DailyChecksScreen extends StatefulWidget {
  const DailyChecksScreen({super.key});

  @override
  State<DailyChecksScreen> createState() => _DailyChecksScreenState();
}

class _DailyChecksScreenState extends State<DailyChecksScreen> {
  DateTime? selectedFrom;

  void loadDailyChecksData() {
    final fromStr = selectedFrom != null
        ? DateFormat('yyyy-MM-dd').format(selectedFrom!)
        : "";
    context
        .read<DailyChecksBloc>()
        .add(DailyChecksStarted(from: fromStr, to: fromStr));
  }

  @override
  void initState() {
    super.initState();
    loadDailyChecksData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyChecksBloc, DailyChecksState>(
      builder: (context, state) {
        final model = state is DailyChecksSuccess ? state.model : null;
        return AppPage(
          toolbar: AppPageHeader(
            leading: AppBackButton(
              tooltip: tr("back_to_cash"),
              onTap: () => context.go("/cash"),
            ),
            icon: Icons.summarize_rounded,
            title: tr("daily_receipt"),
            actions: [
              AppDateField(
                value: selectedFrom,
                onSelected: (date) {
                  setState(() => selectedFrom = date);
                  loadDailyChecksData();
                },
                onClear: () {
                  setState(() => selectedFrom = null);
                  loadDailyChecksData();
                },
              ),
              if (model != null) DailyChecks(dailyCheckModel: model),
              AppIconButton(
                icon: Icons.autorenew_rounded,
                tooltip: tr("refresh"),
                onPressed: loadDailyChecksData,
              ),
            ],
          ),
          child: switch (state) {
            DailyChecksFailure(:final error) => AppErrorState(
                message: error.message,
                onRetry: loadDailyChecksData,
              ),
            DailyChecksSuccess(:final model) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SummarySection(model: model),
                  const SizedBox(height: AppSpacing.xl),
                  AppSectionHeader(title: tr("sold_products")),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(child: ProductsTable(model: model)),
                ],
              ),
            _ => const AppLoading(),
          },
        );
      },
    );
  }
}
