import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../domain/model/daily_checks_model.dart';

class SummarySection extends StatelessWidget {
  final DailyChecksModel model;

  const SummarySection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      AppStatTile(
        label: tr("total_sum"),
        value: formatCurrency(model.totalSum),
        icon: Icons.point_of_sale_rounded,
      ),
      AppStatTile(
        label: tr("cash"),
        value: formatCurrency(model.totalCash),
        icon: Icons.payments_rounded,
        color: AppColors.success,
      ),
      AppStatTile(
        label: tr("card"),
        value: formatCurrency(model.totalCard),
        icon: Icons.credit_card_rounded,
        color: AppColors.info,
      ),
      AppStatTile(
        label: tr("on_credit"),
        value: formatCurrency(model.totalDebt),
        icon: Icons.request_quote_rounded,
        color: AppColors.danger,
      ),
      AppStatTile(
        label: tr("cashier_name"),
        value: model.user.name,
        icon: Icons.badge_rounded,
        color: AppColors.textSecondary,
      ),
    ];
    return AppAdaptiveRow(children: tiles);
  }
}
