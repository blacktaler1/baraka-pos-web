import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../aplication/configs/app_brand.dart';

class ForbiddenScreen extends StatelessWidget {
  const ForbiddenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(child: BrandLogo(size: 32)),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.dangerSoft,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.danger,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        tr("account_blocked_title"),
                        style: AppText.h2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tr("account_blocked_body"),
                        style: AppText.body
                            .copyWith(color: AppColors.textSecondary),
                      ),
                      if (kSupportPhone.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          kSupportPhone,
                          style: AppText.h2.copyWith(color: AppColors.primary),
                        ),
                      ],
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () => context.go("/auth"),
                          child: Text(tr("close_page")),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
