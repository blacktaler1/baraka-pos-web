import 'package:baraka_pos/features/firma/presentation/screens/create_firma_screen.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/firma_model.dart';
import '../blocs/get_by_id_firma_bloc/get_by_id_firma_bloc.dart';

class FirmaInfoCard extends StatelessWidget {
  const FirmaInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetByIdFirmaBloc, GetByIdFirmaState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          inPrepare: () => const SizedBox(height: 190, child: AppLoading()),
          failure: (error) =>
              AppCard(child: AppErrorState(message: error.message)),
          success: (model) => context.isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _profile(context, model),
                    const SizedBox(height: AppSpacing.xs),
                    SizedBox(height: 200, child: _stats(model)),
                  ],
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 5, child: _profile(context, model)),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(flex: 6, child: _stats(model)),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _profile(BuildContext context, FirmaModel model) {
    final imageUrl =
        model.images.models.isNotEmpty ? model.images.models.first.file : null;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Dekorativ doiralar
          Positioned(
            right: -40,
            top: -40,
            child: _circle(140, 0.07),
          ),
          Positioned(
            right: 60,
            bottom: -50,
            child: _circle(100, 0.05),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: AppAvatar(
                    name: model.title,
                    imageUrl: imageUrl,
                    size: 68,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: AppText.h2.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      _infoLine(Icons.call_rounded, model.phone),
                      const SizedBox(height: AppSpacing.xxs),
                      _infoLine(Icons.location_on_rounded, model.address),
                      const SizedBox(height: AppSpacing.md),
                      Material(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          onTap: () => showFirmaPanel(context, firma: model),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 7,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.edit_note_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "edit_information".tr(),
                                  style: AppText.label
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, double alpha) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: alpha),
        ),
      );

  Widget _infoLine(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.white.withValues(alpha: 0.7)),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            text.isEmpty ? '-' : text,
            style: AppText.small.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _stats(FirmaModel model) {
    String money(num v) => formatCurrency(v.toString());
    final paidShare = model.totalDebt > 0
        ? (model.totalPaid / model.totalDebt).clamp(0, 1).toDouble()
        : 1.0;

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _StatTile(
                  label: tr("total_products"),
                  value: "${model.totalProducts} ${tr("items_count")}",
                  icon: Icons.inventory_2_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _StatTile(
                  label: tr("total_debt"),
                  value: money(model.totalDebt),
                  icon: Icons.account_balance_wallet_rounded,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _StatTile(
                  label: tr("paid"),
                  value: money(model.totalPaid),
                  icon: Icons.price_check_rounded,
                  color: AppColors.success,
                  progress: paidShare,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _StatTile(
                  label: tr("remaining_debt"),
                  value: money(model.remainder),
                  icon: Icons.hourglass_bottom_rounded,
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  /// To'langan ulush (0..1) — faqat "To'langan" kartasida
  final double? progress;

  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return AppSoftCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppSoftIcon(icon: icon, color: color, size: 42),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppText.small,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(value, style: AppText.h3),
                ),
                if (progress != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 4,
                            backgroundColor: AppColors.surfaceSunken,
                            valueColor: AlwaysStoppedAnimation(color),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${(progress! * 100).toStringAsFixed(0)}%",
                        style: AppText.caption.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
