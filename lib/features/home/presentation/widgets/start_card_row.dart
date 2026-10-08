import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../home.dart';

class StatCardsRow extends StatelessWidget {
  final CardsModel cards;
  final String currentPeriod; // Tanlangan periodni qabul qilamiz

  /// Aylanma kartasidagi mini-grafik uchun sotuvlar qatori
  final List sparkline;

  const StatCardsRow({
    super.key,
    required this.cards,
    required this.currentPeriod, // Majburiy field
    this.sparkline = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppAdaptiveRow(
      children: [
        _StatCard(
          highlighted: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TurnoverDetailScreen(
                  period: currentPeriod,
                ), // Period uzatildi
              ),
            );
          },
          title: tr("turnover"),
          value: cards.turnover.value.toDouble(),
          pct: cards.turnover.pct.toDouble(),
          color: AppColors.primary,
          icon: Icons.storefront_rounded,
          sparkline: sparkline.map((e) => (e as num).toDouble()).toList(),
        ),
        _StatCard(
          onTap: () {
            context.goNamed('expenses');
          },
          title: tr("expenses"),
          value: cards.expenses.value.toDouble(),
          pct: cards.expenses.pct.toDouble(),
          color: AppColors.danger,
          icon: Icons.payments_rounded,
          // Xarajat o'sishi — salbiy holat
          inverseTrend: true,
        ),
        _StatCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfitDetailScreen(period: currentPeriod),
              ),
            );
          },
          title: tr("profit"),
          value: cards.profit.value.toDouble(),
          pct: cards.profit.pct.toDouble(),
          color: AppColors.success,
          icon: Icons.auto_graph_rounded,
        ),
        _StatCard(
          onTap: null,
          title: tr("total_debt"),
          value: cards.debt.value.toDouble(),
          pct: cards.debt.pct.toDouble(),
          color: AppColors.warning,
          icon: Icons.account_balance_wallet_rounded,
          inverseTrend: true,
        ),
      ],
    );
  }
}

class _StatCard extends StatefulWidget {
  final VoidCallback? onTap;
  final String title;
  final double value;
  final double pct;
  final Color color;
  final IconData icon;
  final bool highlighted;
  final bool inverseTrend;
  final List<double> sparkline;

  const _StatCard({
    required this.onTap,
    required this.title,
    required this.value,
    required this.pct,
    required this.color,
    required this.icon,
    this.highlighted = false,
    this.inverseTrend = false,
    this.sparkline = const [],
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;

  String get _pctText {
    final v = widget.pct.abs();
    return v == v.roundToDouble()
        ? "${v.toInt()}%"
        : "${v.toStringAsFixed(1)}%";
  }

  @override
  Widget build(BuildContext context) {
    final hl = widget.highlighted;
    final isUp = widget.pct >= 0;
    final isGood = widget.inverseTrend ? !isUp : isUp;

    final Color fg = hl ? Colors.white : AppColors.ink;
    final Color fgMuted =
        hl ? Colors.white.withValues(alpha: 0.72) : AppColors.textSecondary;
    final Color trendColor =
        hl ? Colors.white : (isGood ? AppColors.success : AppColors.danger);
    final Color trendBg = hl
        ? Colors.white.withValues(alpha: 0.16)
        : (isGood ? AppColors.successSoft : AppColors.dangerSoft);

    final clickable = widget.onTap != null;

    return MouseRegion(
      cursor: clickable ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: 168,
          transform:
              Matrix4.translationValues(0, _hovered && clickable ? -2 : 0, 0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: hl ? null : AppColors.surface,
            gradient: hl
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
                  )
                : null,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: hl
                ? null
                : Border.all(
                    color: _hovered ? AppColors.borderStrong : AppColors.border,
                  ),
            boxShadow: [
              BoxShadow(
                color: hl
                    ? AppColors.primary
                        .withValues(alpha: _hovered ? 0.32 : 0.22)
                    : AppColors.shadow,
                blurRadius: _hovered ? 24 : 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Dekorativ fon doirasi
              Positioned(
                right: -28,
                top: -28,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hl
                        ? Colors.white.withValues(alpha: 0.07)
                        : widget.color.withValues(alpha: 0.05),
                  ),
                ),
              ),
              if (hl && widget.sparkline.length > 1)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 56,
                  child: _Sparkline(values: widget.sparkline),
                ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _CardIcon(
                          icon: widget.icon,
                          color: widget.color,
                          inverted: hl,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: trendBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isUp
                                    ? Icons.trending_up_rounded
                                    : Icons.trending_down_rounded,
                                color: trendColor,
                                size: 14,
                              ),
                              const Gap(4),
                              Text(
                                _pctText,
                                style: AppText.caption.copyWith(
                                  color: trendColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(AppSpacing.md),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.bodyMedium.copyWith(color: fgMuted),
                          ),
                        ),
                        if (clickable) ...[
                          const Gap(4),
                          AnimatedSlide(
                            duration: const Duration(milliseconds: 180),
                            offset: Offset(_hovered ? 0.25 : 0, 0),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: fgMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Gap(2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: formatCurrency(
                                widget.value.toStringAsFixed(0),
                                withCurrency: false,
                              ),
                            ),
                            TextSpan(
                              text: " so'm",
                              style:
                                  AppText.bodyMedium.copyWith(color: fgMuted),
                            ),
                          ],
                        ),
                        style: AppText.display.copyWith(color: fg),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool inverted;

  const _CardIcon({
    required this.icon,
    required this.color,
    required this.inverted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: inverted
            ? Colors.white.withValues(alpha: 0.16)
            : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: inverted
              ? Colors.white.withValues(alpha: 0.2)
              : color.withValues(alpha: 0.14),
        ),
      ),
      child: Icon(icon, color: inverted ? Colors.white : color, size: 22),
    );
  }
}

/// Aylanma kartasining pastki qismidagi silliq mini-grafik
class _Sparkline extends StatelessWidget {
  final List<double> values;

  const _Sparkline({required this.values});

  @override
  Widget build(BuildContext context) {
    final maxV = values.reduce((a, b) => a > b ? a : b);
    return IgnorePointer(
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxV <= 0 ? 1 : maxV * 1.1,
          minX: 0,
          maxX: (values.length - 1).toDouble(),
          lineTouchData: const LineTouchData(enabled: false),
          titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < values.length; i++)
                  FlSpot(i.toDouble(), values[i]),
              ],
              isCurved: true,
              preventCurveOverShooting: true,
              barWidth: 2,
              color: Colors.white.withValues(alpha: 0.55),
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.18),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
