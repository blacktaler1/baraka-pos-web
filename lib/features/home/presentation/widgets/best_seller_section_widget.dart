import 'package:baraka_pos/shared/design/design.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'section_conatianer_widget.dart';

class BestSellersSection extends StatelessWidget {
  final List bestSellers;
  final String currentPeriod;
  final Function(String) onPeriodChanged;

  const BestSellersSection({
    super.key,
    required this.bestSellers,
    required this.currentPeriod,
    required this.onPeriodChanged,
  });

  static num _num(dynamic v) =>
      v is num ? v : num.tryParse(v?.toString() ?? "") ?? 0;

  @override
  Widget build(BuildContext context) {
    // Eng katta sotuv — progress chiziqlari uchun 100%
    final maxSales = bestSellers.fold<num>(
      0,
      (m, e) => _num(e['total_sales']) > m ? _num(e['total_sales']) : m,
    );

    return SectionContainer(
      title: tr("most_buying_and_selling"),
      icon: Icons.workspace_premium_rounded,
      iconColor: AppColors.gold,
      content: Column(
        children: [
          if (bestSellers.isEmpty)
            EmptyState(
              icon: Icons.leaderboard_rounded,
              message: tr("not_found"),
            ),
          for (var i = 0; i < bestSellers.length; i++)
            _BestSellerRow(
              rank: i + 1,
              name: bestSellers[i]['title']?.toString() ?? tr("not_found"),
              quantity: _num(bestSellers[i]['quantity']),
              totalSales: _num(bestSellers[i]['total_sales']),
              percentage: _num(bestSellers[i]['percentage']),
              share: maxSales > 0
                  ? (_num(bestSellers[i]['total_sales']) / maxSales).toDouble()
                  : 0,
            ),
        ],
      ),
    );
  }
}

class _BestSellerRow extends StatelessWidget {
  final int rank;
  final String name;
  final num quantity;
  final num totalSales;
  final num percentage;
  final double share;

  const _BestSellerRow({
    required this.rank,
    required this.name,
    required this.quantity,
    required this.totalSales,
    required this.percentage,
    required this.share,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          _RankBadge(rank: rank),
          const Gap(AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppText.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      formatCurrency(totalSales.toStringAsFixed(0)),
                      style: AppText.bodyStrong,
                    ),
                  ],
                ),
                const Gap(6),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: share.clamp(0, 1)),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          builder: (_, v, __) => LinearProgressIndicator(
                            value: v,
                            minHeight: 6,
                            backgroundColor: AppColors.surfaceSunken,
                            valueColor: const AlwaysStoppedAnimation(
                                AppColors.chartSales),
                          ),
                        ),
                      ),
                    ),
                    const Gap(AppSpacing.sm),
                    SizedBox(
                      width: 120,
                      child: Text(
                        "$quantity ${tr("dona")}"
                        "${percentage > 0 ? " · ${percentage.toStringAsFixed(0)}%" : ""}",
                        textAlign: TextAlign.right,
                        style: AppText.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;

  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    // Top-3 uchun medal ikonasi, qolganlari uchun raqam
    final top = rank <= 3;
    const medal = [Color(0xFFE2B04A), Color(0xFF9EA3A8), Color(0xFFC07A45)];
    final color = top ? medal[rank - 1] : AppColors.textTertiary;

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: top ? color.withValues(alpha: 0.14) : AppColors.surfaceSunken,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: top
          ? Icon(Icons.military_tech_rounded, color: color, size: 24)
          : Text(
              "$rank",
              style:
                  AppText.bodyStrong.copyWith(color: AppColors.textSecondary),
            ),
    );
  }
}
