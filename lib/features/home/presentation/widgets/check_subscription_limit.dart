import 'package:baraka_pos/shared/aplication/configs/app_brand.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void checkSubscriptionLimit(BuildContext context, String limitDateString) {
  if (limitDateString.isEmpty) return;

  final limitDate = DateTime.parse(limitDateString).toLocal();
  final daysLeft = limitDate.difference(DateTime.now()).inDays;
  if (daysLeft < 0 || daysLeft >= 3) return;

  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: IconTile(
                  icon: Icons.notifications_active_rounded,
                  color: AppColors.warning,
                  size: 44,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text("subscription_ending_title".tr(), style: AppText.h2),
              const SizedBox(height: AppSpacing.xs),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "subscription_ending_desc".tr()),
                    TextSpan(
                      text: daysLeft == 0
                          ? "today_last_day".tr()
                          : "days_left".tr(args: [daysLeft.toString()]),
                      style: const TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                style: AppText.body.copyWith(color: AppColors.textSecondary),
              ),
              if (kSupportPhone.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                AppInfoGrid(
                  columns: 1,
                  items: [("contact_admin".tr(), kSupportPhone)],
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: "got_it".tr(),
                expand: true,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
