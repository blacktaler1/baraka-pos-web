import 'package:flutter/services.dart';
import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/settings/presentation/presentation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/data/sources/local_sources.dart';
import '../../../../shared/shared.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserTableData? currentUser;
  String? appVersion;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await sl<AuthLocalSource>().getCurrentUser();
    final version = await getProjectVersion();
    await UsdRate.load();
    if (!mounted) return;
    setState(() {
      currentUser = user;
      appVersion = version;
      loading = false;
    });
  }

  Future<void> _editUsdRate(double? current) async {
    final ctrl = TextEditingController(
      text: current == null
          ? ""
          : current.toStringAsFixed(current % 1 == 0 ? 0 : 2),
    );
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(tr("usd_rate"), style: AppText.h2),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  label: tr("usd_rate_hint"),
                  controller: ctrl,
                  usd: false,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: AppSpacing.sm,
                  children: [
                    AppButton.secondary(
                      label: tr("cancel"),
                      onPressed: () => Navigator.pop(dialogContext, false),
                    ),
                    AppButton(
                      label: tr("save"),
                      icon: Icons.check_circle_rounded,
                      onPressed: () => Navigator.pop(dialogContext, true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (saved != true) return;
    final rate =
        double.tryParse(ctrl.text.replaceAll(' ', '').replaceAll(',', '.'));
    await UsdRate.save(rate);
  }

  Future<void> _logout() async {
    final confirmed = await showAppConfirm(
      context,
      title: tr("logout"),
      message: tr("logout_confirm"),
      confirmLabel: tr("logout"),
      danger: true,
    );
    if (!confirmed || !mounted) return;
    AuthLocalSource(PosLocalDatabase.instance).logout();
    context.go("/auth");
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    if (loading) {
      return const Scaffold(
        backgroundColor: AppColors.canvas,
        body: AppLoading(),
      );
    }

    final user = currentUser;
    final isAdmin = user?.role == 'admin';

    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: ListView(
            padding: context.isMobile
                ? const EdgeInsets.fromLTRB(12, 12, 12, 24)
                : const EdgeInsets.fromLTRB(28, 24, 28, 32),
            children: [
              AppPageHeader(
                icon: Icons.settings_rounded,
                title: tr("settings"),
                subtitle:
                    appVersion == null ? null : "${tr("version")} $appVersion",
              ),
              const SizedBox(height: AppSpacing.xl),
              _ProfileCard(user: user),
              const SizedBox(height: AppSpacing.md),
              if ((user?.limit ?? '').isNotEmpty) ...[
                _SubscriptionCard(limit: user!.limit),
                const SizedBox(height: AppSpacing.xl),
              ],
              _SettingsGroup(
                title: tr("account_section"),
                children: [
                  _SettingsTile(
                    icon: Icons.lock_reset_rounded,
                    color: AppColors.info,
                    title: tr("change_password"),
                    onTap: () => showChangePasswordPanel(context),
                  ),
                  ValueListenableBuilder<double?>(
                    valueListenable: UsdRate.current,
                    builder: (context, rate, _) => _SettingsTile(
                      icon: Icons.attach_money_rounded,
                      color: AppColors.success,
                      title: tr("usd_rate"),
                      trailingText: rate == null
                          ? tr("not_set")
                          : formatCurrency(
                              rate.toStringAsFixed(rate % 1 == 0 ? 0 : 2)),
                      onTap: () => _editUsdRate(rate),
                    ),
                  ),
                  if (isAdmin)
                    _SettingsTile(
                      icon: Icons.storefront_rounded,
                      color: AppColors.primary,
                      title: tr("shop_info"),
                      onTap: () => showShopInfoPanel(context),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _SettingsGroup(
                title: tr("app_section"),
                children: [
                  // Web versiya sahifa yangilanganda avtomatik yangilanadi
                  _SettingsTile(
                    icon: Icons.verified_rounded,
                    color: AppColors.success,
                    title: tr("version"),
                    trailingText: appVersion,
                    trailing: const SizedBox.shrink(),
                  ),
                  if (kSupportPhone.isNotEmpty)
                    _SettingsTile(
                      icon: Icons.support_agent_rounded,
                      color: AppColors.info,
                      title: tr("contact_us"),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.infoSoft,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.call_rounded,
                                size: 14, color: AppColors.info),
                            const SizedBox(width: 6),
                            Text(
                              kSupportPhone,
                              style: AppText.bodyStrong
                                  .copyWith(color: AppColors.info),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              _LogoutButton(onTap: _logout),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Profil ----------------

class _ProfileCard extends StatelessWidget {
  final UserTableData? user;

  const _ProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final name = (user?.name ?? '').isEmpty ? 'User' : user!.name!;
    final role = user?.role ?? '';

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
          Positioned(
            right: -40,
            top: -50,
            child: _circle(160, 0.07),
          ),
          Positioned(
            right: 90,
            bottom: -60,
            child: _circle(110, 0.05),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    name.characters.first.toUpperCase(),
                    style: AppText.h1.copyWith(color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppText.h2.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.call_rounded,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.75)),
                          const SizedBox(width: 6),
                          Text(
                            (user?.phone ?? '').isEmpty ? '-' : user!.phone,
                            style: AppText.small.copyWith(
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (role.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          role == 'admin'
                              ? Icons.admin_panel_settings_rounded
                              : Icons.badge_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          tr(role),
                          style: AppText.label.copyWith(color: Colors.white),
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
}

// ---------------- Obuna ----------------

class _SubscriptionCard extends StatelessWidget {
  final String limit;

  const _SubscriptionCard({required this.limit});

  @override
  Widget build(BuildContext context) {
    final end = DateTime.tryParse(limit)?.toLocal();
    return AppSoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppSoftIcon(
                icon: Icons.workspace_premium_rounded,
                color: AppColors.gold,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tr("subscription"), style: AppText.h3),
                    if (end != null)
                      Row(
                        children: [
                          const Icon(Icons.event_rounded,
                              size: 13, color: AppColors.textTertiary),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('dd.MM.yyyy  HH:mm').format(end),
                            style: AppText.caption
                                .copyWith(color: AppColors.textTertiary),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          CountdownTimer(limit: limit),
        ],
      ),
    );
  }
}

// ---------------- Guruh va qatorlar ----------------

class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: AppSpacing.xs),
          child: Text(
            title.toUpperCase(),
            style: AppText.caption.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
        AppSoftCard(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0)
                  const Divider(
                    height: 1,
                    indent: 68,
                    endIndent: AppSpacing.md,
                    color: AppColors.border,
                  ),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? trailingText;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.color,
    required this.title,
    this.trailingText,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: AppColors.surfaceMuted,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              AppSoftIcon(icon: icon, color: color, size: 40),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(title, style: AppText.bodyStrong)),
              if (trailingText != null) ...[
                Text(
                  trailingText!,
                  style: AppText.small.copyWith(color: AppColors.textTertiary),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              trailing ??
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: AppColors.textTertiary,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.dangerSoft,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        hoverColor: AppColors.danger.withValues(alpha: 0.08),
        child: Container(
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.danger.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout_rounded,
                  color: AppColors.danger, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Text(
                tr("logout"),
                style: AppText.bodyStrong.copyWith(color: AppColors.danger),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PrinterType { check, barcode }
