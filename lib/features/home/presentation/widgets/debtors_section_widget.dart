import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
// 3.3 Qarz firmalar (O'ng taraf past)
import 'package:baraka_pos/features/home/presentation/presentation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DebtorsSection extends StatelessWidget {
  const DebtorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;

    return SectionContainer(
      title: tr("debtors"),
      icon: Icons.request_quote_rounded,
      iconColor: AppColors.danger,
      content: BlocBuilder<DebtorFirmaBloc, DebtorFirmaState>(
        builder: (context, state) {
          return state.when(
            initial: () => const _Loading(),
            inPrepare: () => const _Loading(),
            failure: (err) => EmptyState(
              icon: Icons.error_outline_rounded,
              message: tr("error"),
            ),
            success: (model) {
              final firms = model.results.models;
              if (firms.isEmpty) {
                return EmptyState(
                  icon: Icons.verified_rounded,
                  message: tr("not_debtors"),
                );
              }

              final maxDebt = firms.fold<num>(
                0,
                (m, e) => e.totalDebt > m ? e.totalDebt : m,
              );

              return Column(
                children: firms.map((item) {
                  final share =
                      maxDebt > 0 ? (item.totalDebt / maxDebt).toDouble() : 0.0;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                    child: Row(
                      children: [
                        AppAvatar(name: item.title, size: 40),
                        const Gap(AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: AppText.bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Gap(AppSpacing.xs),
                                  Text(
                                    formatCurrency(item.totalDebt.toString()),
                                    style: AppText.bodyStrong,
                                  ),
                                ],
                              ),
                              const Gap(6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: share.clamp(0, 1),
                                  minHeight: 5,
                                  backgroundColor: AppColors.surfaceSunken,
                                  valueColor: const AlwaysStoppedAnimation(
                                      AppColors.danger),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}
