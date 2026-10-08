import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/screens/splash_screen.dart';
import '../../shared.dart'; // agar kerak bo'lsa importlarni moslang
import 'package:easy_localization/easy_localization.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  Future<bool> _manualCheck() => checkInternet();

  void _onRetryPressed(BuildContext context) async {
    // Kiritilgan rootNavigatorKey orqali GoRouter kontekstini olishga harakat qilamiz
    final rootCtx = rootNavigatorKey.currentContext;
    final has = await _manualCheck();

    if (has) {
      if (rootCtx != null) {
        // GoRouter orqali /auth ga o'tish
        // ignore: use_build_context_synchronously
        GoRouter.of(rootCtx).go('/splash');
      } else if (context.mounted) {
        // fallback: to'g'ridan-to'g'ri AuthScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SplashScreen()),
        );
      }
    } else {
      // Internet yo'qligi haqida xabar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('still_no_internet'))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const IconTile(
                  icon: Icons.wifi_off_rounded,
                  color: AppColors.warning,
                  size: 56,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(tr('no_internet_title'), style: AppText.h1),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  tr('no_internet_desc'),
                  style: AppText.body.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.xl),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    AppButton(
                      label: tr('retry'),
                      icon: Icons.refresh_rounded,
                      onPressed: () => _onRetryPressed(context),
                    ),
                    AppButton.secondary(
                      label: tr('continue_offline'),
                      onPressed: () => context.go("/splash"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
