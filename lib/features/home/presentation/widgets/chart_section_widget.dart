import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../domain/model/chart_model.dart';
import 'format_label_util.dart';
import 'section_conatianer_widget.dart';

enum _ChartKind { area, bar }

class ChartSection extends StatefulWidget {
  final ChartModel chartModel;
  final String currentPeriod;
  final Function(String) onPeriodChanged;

  const ChartSection({
    super.key,
    required this.chartModel,
    required this.currentPeriod,
    required this.onPeriodChanged,
  });

  @override
  State<ChartSection> createState() => _ChartSectionState();
}

class _ChartSectionState extends State<ChartSection> {
  static const _salesColor = AppColors.chartSales;
  static const _purchaseColor = AppColors.chartPurchase;

  _ChartKind _kind = _ChartKind.area;

  ChartModel get _m => widget.chartModel;

  List<double> get _sales =>
      _m.sales.map((e) => (e as num).toDouble()).toList();
  List<double> get _purchase =>
      _m.purchase.map((e) => (e as num).toDouble()).toList();

  @override
  Widget build(BuildContext context) {
    final sales = _sales;
    final purchase = _purchase;

    // --- DINAMIK MAX Y: eng katta qiymat + 20% joy, 5 qatorli setka ---
    final allValues = [...sales, ...purchase];
    double maxValue =
        allValues.isEmpty ? 1000 : allValues.reduce((a, b) => a > b ? a : b);
    if (maxValue <= 0) maxValue = 1000;
    final maxY = maxValue * 1.2;
    final interval = maxY / 5;

    return SectionContainer(
      title: tr("buying_and_selling"),
      icon: Icons.query_stats_rounded,
      trailing: _ChartKindToggle(
        value: _kind,
        onChanged: (k) => setState(() => _kind = k),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSpacing.sm),
          // Jami qiymatlar — legenda vazifasini ham bajaradi
          Wrap(
            spacing: AppSpacing.xxl,
            runSpacing: AppSpacing.xs,
            children: [
              _TotalLegend(
                color: _salesColor,
                label: tr("sales"),
                value: _m.totalSales,
              ),
              _TotalLegend(
                color: _purchaseColor,
                label: tr("chart_purchases"),
                value: _m.totalPurchase,
              ),
            ],
          ),
          const Gap(AppSpacing.xl),
          SizedBox(
            height: context.isMobile ? 230 : 290,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _kind == _ChartKind.area
                  ? _buildArea(sales, purchase, maxY, interval)
                  : _buildBar(sales, purchase, maxY, interval),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- umumiy o'qlar va setka ----------

  FlTitlesData _titles(double interval) {
    return FlTitlesData(
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 48,
          interval: interval,
          getTitlesWidget: (value, meta) {
            if (value > meta.max) return const SizedBox.shrink();
            return SideTitleWidget(
              axisSide: meta.axisSide,
              space: 10,
              child: Text(
                _compact(value),
                style: AppText.caption.copyWith(color: AppColors.textTertiary),
              ),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (value != index.toDouble() ||
                index < 0 ||
                index >= _m.labels.length) {
              return const SizedBox.shrink();
            }
            // Zich davrlarda (kun/oy) har N-chi yorliqni ko'rsatamiz
            final count = _m.labels.length;
            final stride = count > 20 ? 4 : (count > 12 ? 2 : 1);
            if (index % stride != 0) return const SizedBox.shrink();
            return SideTitleWidget(
              axisSide: meta.axisSide,
              space: 8,
              child: Text(
                formatLabel(
                  label: _m.labels[index].toString(),
                  index: index,
                  period: widget.currentPeriod,
                ),
                style: AppText.caption.copyWith(color: AppColors.textTertiary),
              ),
            );
          },
        ),
      ),
    );
  }

  FlGridData _grid(double interval) => FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: interval,
        getDrawingHorizontalLine: (_) => const FlLine(
          color: AppColors.border,
          strokeWidth: 1,
          dashArray: [4, 4],
        ),
      );

  // ---------- chiziqli (area) grafik ----------

  Widget _buildArea(
    List<double> sales,
    List<double> purchase,
    double maxY,
    double interval,
  ) {
    LineChartBarData line(List<double> values, Color color) {
      return LineChartBarData(
        spots: [
          for (var i = 0; i < values.length; i++)
            FlSpot(i.toDouble(), values[i]),
        ],
        isCurved: true,
        curveSmoothness: 0.3,
        preventCurveOverShooting: true,
        color: color,
        barWidth: 2.5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withValues(alpha: 0.22),
              color.withValues(alpha: 0.0),
            ],
          ),
        ),
      );
    }

    return LineChart(
      key: const ValueKey('area'),
      LineChartData(
        minY: 0,
        maxY: maxY,
        minX: 0,
        maxX: (_m.labels.length - 1).clamp(0, 1 << 20).toDouble(),
        titlesData: _titles(interval),
        gridData: _grid(interval),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          getTouchedSpotIndicator: (bar, indexes) => indexes
              .map(
                (_) => TouchedSpotIndicatorData(
                  const FlLine(
                    color: AppColors.borderStrong,
                    strokeWidth: 1,
                    dashArray: [3, 3],
                  ),
                  FlDotData(
                    getDotPainter: (spot, _, b, __) => FlDotCirclePainter(
                      radius: 5,
                      color: b.color ?? AppColors.primary,
                      strokeWidth: 2.5,
                      strokeColor: AppColors.surface,
                    ),
                  ),
                ),
              )
              .toList(),
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: AppColors.ink,
            tooltipRoundedRadius: 10,
            tooltipPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItems: (spots) => spots.map((s) {
              final isSales = s.barIndex == 0;
              final header =
                  s == spots.first ? "${_m.labels[s.x.toInt()]}\n" : "";
              return LineTooltipItem(
                header,
                AppText.caption.copyWith(color: Colors.white70),
                textAlign: TextAlign.left,
                children: [
                  TextSpan(
                    text: "● ",
                    style: TextStyle(
                      color: isSales ? _salesColor : _purchaseColor,
                    ),
                  ),
                  TextSpan(
                    text: "${isSales ? tr("sales") : tr("chart_purchases")}: ",
                    style: AppText.caption.copyWith(color: Colors.white70),
                  ),
                  TextSpan(
                    text: formatCurrency(s.y.toStringAsFixed(0)),
                    style: AppText.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        lineBarsData: [
          line(sales, _salesColor),
          line(purchase, _purchaseColor),
        ],
      ),
    );
  }

  // ---------- ustunli (bar) grafik ----------

  Widget _buildBar(
    List<double> sales,
    List<double> purchase,
    double maxY,
    double interval,
  ) {
    final count = _m.labels.length;
    // Ko'p ustunli davrlarda ustunlar ingichkaroq
    final double rodWidth = count > 20 ? 6 : (count > 10 ? 9 : 14);

    return BarChart(
      key: const ValueKey('bar'),
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        titlesData: _titles(interval),
        gridData: _grid(interval),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: AppColors.ink,
            tooltipRoundedRadius: 10,
            tooltipPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItem: (group, _, rod, rodIndex) {
              final isSales = rodIndex == 1;
              return BarTooltipItem(
                "${_m.labels[group.x]}\n",
                AppText.caption.copyWith(color: Colors.white70),
                children: [
                  TextSpan(
                    text: "${isSales ? tr("sales") : tr("chart_purchases")}: ",
                    style: AppText.caption.copyWith(color: Colors.white70),
                  ),
                  TextSpan(
                    text: formatCurrency(rod.toY.toStringAsFixed(0)),
                    style: AppText.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        barGroups: List.generate(count, (index) {
          BarChartRodData rod(double v, Color c) => BarChartRodData(
                toY: v,
                color: c,
                width: rodWidth,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: AppColors.surfaceMuted,
                ),
              );
          return BarChartGroupData(
            x: index,
            barsSpace: 2,
            barRods: [
              rod(purchase[index], _purchaseColor),
              rod(sales[index], _salesColor),
            ],
          );
        }),
      ),
    );
  }

  static String _compact(double value) {
    if (value >= 1000000000) {
      return "${(value / 1000000000).toStringAsFixed(1)}B";
    }
    if (value >= 1000000) return "${(value / 1000000).toStringAsFixed(1)}M";
    if (value >= 1000) return "${(value / 1000).toInt()}K";
    return value.toInt().toString();
  }
}

class _TotalLegend extends StatelessWidget {
  final Color color;
  final String label;
  final num value;

  const _TotalLegend({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const Gap(6),
            Text(label, style: AppText.caption),
          ],
        ),
        const Gap(2),
        Text(
          formatCurrency(value.toStringAsFixed(0)),
          style: AppText.h2,
        ),
      ],
    );
  }
}

class _ChartKindToggle extends StatelessWidget {
  final _ChartKind value;
  final ValueChanged<_ChartKind> onChanged;

  const _ChartKindToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget item(_ChartKind kind, IconData icon) {
      final active = kind == value;
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onChanged(kind),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 34,
            height: 30,
            decoration: BoxDecoration(
              color: active ? AppColors.surface : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              boxShadow: active
                  ? const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              icon,
              size: 18,
              color: active ? AppColors.primary : AppColors.textTertiary,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surfaceSunken,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          item(_ChartKind.area, Icons.show_chart_rounded),
          item(_ChartKind.bar, Icons.bar_chart_rounded),
        ],
      ),
    );
  }
}
