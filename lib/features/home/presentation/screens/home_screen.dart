import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../auth/presentation/screens/splash_screen.dart';
import '../../home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Periodlarni saqlash uchun o'zgaruvchilar
  String _cardsP = "month";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkSubscriptionLimit(context, globalUser!.limit);
    });
    _fetchInitialData();
  }

  void _fetchInitialData() {
    // 1. Dashboard
    _updateDashboard();

    // 2. Low stock
    context.read<LowStockBloc>().add(const LowStockEvent(
          pageSize: 5,
          lowStock: true,
          category: "",
          cursor: "",
          firmaId: 0,
          search: "",
        ));

    // 3. Debtors
    context.read<DebtorFirmaBloc>().add(const DebtorFirmaEvent(
          pageSize: 5,
          debt: true,
          cursor: "",
          search: "",
        ));
  }

  void _updateDashboard() {
    context.read<GetDashboardBloc>().add(
          GetDashboardEvent(
            cardsPeriod: _cardsP,
            chartPeriod: _cardsP,
            topProductPeriod: _cardsP,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: BlocBuilder<GetDashboardBloc, GetDashboardState>(
        builder: (context, state) {
          return state.when(
            initial: () => const AppLoading(),
            inPrepare: () => const AppLoading(),
            failure: (error) => AppErrorState(
              message: "${tr("error")} $error",
              onRetry: _updateDashboard,
            ),
            success: (dashboardModel) => _DesktopDashboardContent(
              dashboardModel: dashboardModel,
              cardsP: _cardsP,
              chartP: _cardsP,
              topP: _cardsP,
              // Callbacklar orqali state-ni yangilaymiz
              onUpdate: (type, newPeriod) {
                setState(() {
                  if (type == 'cards') _cardsP = newPeriod;
                  if (type == 'chart') _cardsP = newPeriod;
                  if (type == 'top') _cardsP = newPeriod;
                });
                _updateDashboard();
              },
            ),
          );
        },
      ),
    );
  }
}

class _DesktopDashboardContent extends StatelessWidget {
  final DashboardModel dashboardModel;
  final String cardsP, chartP, topP;
  final Function(String type, String period) onUpdate;

  const _DesktopDashboardContent({
    required this.dashboardModel,
    required this.cardsP,
    required this.chartP,
    required this.topP,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = "${now.day.toString().padLeft(2, '0')}."
        "${now.month.toString().padLeft(2, '0')}.${now.year}";

    final mobile = context.isMobile;
    final gap = mobile ? AppSpacing.sm : 20.0;
    final period = PeriodSelector(
      currentPeriod: cardsP,
      onSelected: (p) => onUpdate('cards', p),
    );
    final chart = ChartSection(
      chartModel: dashboardModel.charts,
      currentPeriod: chartP,
      onPeriodChanged: (p) => onUpdate('chart', p),
    );
    final bestSellers = BestSellersSection(
      bestSellers: dashboardModel.topProducts,
      currentPeriod: topP,
      onPeriodChanged: (p) => onUpdate('top', p),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(mobile ? AppSpacing.sm : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: mobile ? 40 : 48,
                height: mobile ? 40 : 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const Gap(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("dashboard_title"),
                      style: mobile ? AppText.h2 : AppText.h1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 13,
                          color: AppColors.textTertiary,
                        ),
                        const Gap(6),
                        Text(
                          today,
                          style: AppText.caption
                              .copyWith(color: AppColors.textTertiary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!mobile) period,
            ],
          ),
          if (mobile) ...[
            const Gap(AppSpacing.sm),
            period,
          ],
          Gap(mobile ? AppSpacing.sm : 24),
          StatCardsRow(
            cards: dashboardModel.cards,
            currentPeriod: cardsP,
            sparkline: dashboardModel.charts.sales,
          ),
          Gap(gap),
          // Telefonda bo'limlar ustma-ust joylashadi
          if (mobile) ...[
            chart,
            Gap(gap),
            const LowStockSection(),
            Gap(gap),
            bestSellers,
            Gap(gap),
            const DebtorsSection(),
          ] else ...[
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 2, child: chart),
                  const Gap(20),
                  const Expanded(flex: 1, child: LowStockSection()),
                ],
              ),
            ),
            const Gap(20),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 2, child: bestSellers),
                  const Gap(20),
                  const Expanded(flex: 1, child: DebtorsSection()),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
