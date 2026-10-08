import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/screens/splash_screen.dart';
import '../../design/design.dart';

class AppShellScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppShellScaffold({
    super.key,
    required this.navigationShell,
  });

  @override
  State<AppShellScaffold> createState() => _AppShellScaffoldState();
}

class _NavEntry {
  final IconData icon;
  final IconData activeIcon;
  final String labelKey;

  const _NavEntry(this.icon, this.activeIcon, this.labelKey);
}

// Tartib router'dagi branch indekslariga mos bo'lishi shart
const _mainNav = [
  _NavEntry(Icons.analytics_outlined, Icons.analytics_rounded, 'dashboard'),
  _NavEntry(Icons.warehouse_outlined, Icons.warehouse_rounded, 'warehouse'),
  _NavEntry(Icons.point_of_sale_outlined, Icons.point_of_sale_rounded, 'sales'),
  _NavEntry(Icons.badge_outlined, Icons.badge_rounded, 'workers'),
  _NavEntry(
      Icons.local_shipping_outlined, Icons.local_shipping_rounded, 'company'),
  _NavEntry(Icons.category_outlined, Icons.category_rounded, 'category'),
  _NavEntry(Icons.groups_outlined, Icons.groups_rounded, 'debtor_customers'),
  _NavEntry(
      Icons.receipt_long_outlined, Icons.receipt_long_rounded, 'expenses'),
  _NavEntry(Icons.compare_arrows_rounded, Icons.compare_arrows_rounded,
      'stock_operations'),
];

const _settingsNav =
    _NavEntry(Icons.settings_outlined, Icons.settings_rounded, 'settings');
const _settingsIndex = 9;

// Har bir bo'lim qaysi rollarga ochiq (router'dagi RoleGuard bilan bir xil)
const _branchRoles = [
  'admin',
  'manager',
  'cashier,manager',
  'admin',
  'manager',
  'manager',
  'cashier,manager',
  'cashier,manager',
  'manager',
];

bool _allowed(int index) {
  final role = globalUser?.role;
  if (role == null || role == 'admin') return true;
  if (index >= _branchRoles.length) return true;
  return _branchRoles[index].contains(role);
}

// Telefonda pastki panelda ko'rinadigan bo'limlar (ustuvorlik tartibida)
const _bottomCandidates = [2, 1, 0, 6, 7];

const _sidebarTop = Color(0xFF145C45);
const _sidebarBottom = Color(0xFF0B3D2E);

class _AppShellScaffoldState extends State<AppShellScaffold> {
  bool collapsed = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _go(int index) =>
      widget.navigationShell.goBranch(index, initialLocation: true);

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        Widget option(String code, String title, String flag) {
          final selected = context.locale.languageCode == code;
          return Material(
            color: selected ? AppColors.primarySoft : AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              side: BorderSide(
                color: selected ? AppColors.primary : AppColors.border,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: () {
                context.setLocale(Locale(code));
                Navigator.pop(dialogContext);
              },
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(flag),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Text(title, style: AppText.bodyStrong)),
                    Icon(
                      selected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      color:
                          selected ? AppColors.primary : AppColors.borderStrong,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Dialog(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const AppSoftIcon(
                        icon: Icons.translate_rounded,
                        color: AppColors.info,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(tr("select_language"), style: AppText.h2),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  option('uz', "O‘zbekcha", "assets/images/uz-flag.png"),
                  const SizedBox(height: AppSpacing.xs),
                  option('ru', "Русский", "assets/images/ru-flag.png"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _currentFlag(BuildContext context) {
    if (context.locale.languageCode == 'uz') {
      return "assets/images/uz-flag.png";
    }
    return "assets/images/ru-flag.png";
  }

  _NavEntry? _currentEntry() {
    final index = widget.navigationShell.currentIndex;
    if (index == _settingsIndex) return _settingsNav;
    if (index < _mainNav.length) return _mainNav[index];
    return null;
  }

  // ---------------- Telefon ko'rinishi ----------------

  Widget _buildMobile(BuildContext context) {
    final current = widget.navigationShell.currentIndex;
    final bottom = _bottomCandidates.where(_allowed).take(4).toList();
    final selected = bottom.indexOf(current);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.canvas,
      drawer: Drawer(
        width: 290,
        backgroundColor: _sidebarBottom,
        shape: const RoundedRectangleBorder(),
        child: _Sidebar(
          collapsed: false,
          inDrawer: true,
          currentIndex: current,
          onToggle: () => Navigator.pop(context),
          onSelect: (index) {
            Navigator.pop(context);
            _go(index);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_sidebarTop, _sidebarBottom],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: 56,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                      icon: const Icon(Icons.menu_rounded,
                          color: Colors.white, size: 26),
                    ),
                    const Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: BrandLogo(size: 26, inverse: true),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => _showLanguageDialog(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 11,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage(_currentFlag(context)),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              context.locale.languageCode.toUpperCase(),
                              style:
                                  AppText.label.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: widget.navigationShell),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 64,
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primarySoft,
          surfaceTintColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => AppText.caption.copyWith(
              fontSize: 11,
              color: states.contains(WidgetState.selected)
                  ? AppColors.primary
                  : AppColors.textSecondary,
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          ),
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: NavigationBar(
            selectedIndex: selected < 0 ? bottom.length : selected,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (i) {
              if (i == bottom.length) {
                _scaffoldKey.currentState?.openDrawer();
              } else {
                _go(bottom[i]);
              }
            },
            destinations: [
              for (final i in bottom)
                NavigationDestination(
                  icon: Icon(_mainNav[i].icon, color: AppColors.textSecondary),
                  selectedIcon:
                      Icon(_mainNav[i].activeIcon, color: AppColors.primary),
                  label: tr(_mainNav[i].labelKey),
                ),
              NavigationDestination(
                icon: const Icon(Icons.apps_rounded,
                    color: AppColors.textSecondary),
                selectedIcon:
                    const Icon(Icons.apps_rounded, color: AppColors.primary),
                label: tr("menu"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return _buildMobile(context);
    final entry = _currentEntry();
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: Row(
        children: [
          _Sidebar(
            collapsed: collapsed,
            currentIndex: widget.navigationShell.currentIndex,
            onToggle: () => setState(() => collapsed = !collapsed),
            onSelect: _go,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: AppSizes.topBarHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(
                      bottom: BorderSide(color: AppColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (entry != null) ...[
                        AppSoftIcon(icon: entry.activeIcon, size: 36),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Baraka POS",
                                  style: AppText.caption.copyWith(
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 14,
                                  color: AppColors.textTertiary,
                                ),
                                Text(
                                  entry == null ? '' : tr(entry.labelKey),
                                  style: AppText.caption,
                                ),
                              ],
                            ),
                            Text(
                              entry == null ? '' : tr(entry.labelKey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.h3,
                            ),
                          ],
                        ),
                      ),
                      const _ClockChip(),
                      const SizedBox(width: AppSpacing.sm),
                      _TopBarButton(
                        tooltip: tr("select_language"),
                        onTap: () => _showLanguageDialog(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage(_currentFlag(context)),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                context.locale.languageCode.toUpperCase(),
                                style: AppText.label,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 18,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: widget.navigationShell),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Yon panel ----------------

class _Sidebar extends StatelessWidget {
  final bool collapsed;
  final bool inDrawer;
  final int currentIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onToggle;

  const _Sidebar({
    required this.collapsed,
    required this.currentIndex,
    required this.onSelect,
    required this.onToggle,
    this.inDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    final visible = [
      for (var i = 0; i < _mainNav.length; i++)
        if (_allowed(i)) i,
    ];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: inDrawer ? null : (collapsed ? 80 : AppSizes.sidebarWidth),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_sidebarTop, _sidebarBottom],
        ),
      ),
      child: Stack(
        children: [
          // Dekorativ yorug'lik doirasi
          Positioned(
            left: -60,
            top: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (inDrawer) SizedBox(height: MediaQuery.paddingOf(context).top),
              SizedBox(
                height: AppSizes.topBarHeight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: collapsed ? 0 : 20),
                  child: Row(
                    mainAxisAlignment: collapsed
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      if (!collapsed)
                        const Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: BrandLogo(size: 30, inverse: true),
                          ),
                        ),
                      _CollapseButton(
                        collapsed: collapsed,
                        onTap: onToggle,
                        closeIcon: inDrawer,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.white.withValues(alpha: 0.08),
              ),
              if (!collapsed)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 4),
                  child: Text(
                    tr("menu").toUpperCase(),
                    style: AppText.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: collapsed ? 14 : 12,
                    vertical: 8,
                  ),
                  itemCount: visible.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemBuilder: (context, i) => _NavItem(
                    entry: _mainNav[visible[i]],
                    collapsed: collapsed,
                    selected: currentIndex == visible[i],
                    onTap: () => onSelect(visible[i]),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.white.withValues(alpha: 0.08),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  collapsed ? 14 : 12,
                  collapsed ? 14 : 12,
                  collapsed ? 14 : 12,
                  (collapsed ? 14 : 12) + MediaQuery.paddingOf(context).bottom,
                ),
                child: _NavItem(
                  entry: _settingsNav,
                  collapsed: collapsed,
                  selected: currentIndex == _settingsIndex,
                  onTap: () => onSelect(_settingsIndex),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CollapseButton extends StatelessWidget {
  final bool collapsed;
  final VoidCallback onTap;
  final bool closeIcon;

  const _CollapseButton({
    required this.collapsed,
    required this.onTap,
    this.closeIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: onTap,
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(
            closeIcon
                ? Icons.close_rounded
                : collapsed
                    ? Icons.keyboard_double_arrow_right_rounded
                    : Icons.keyboard_double_arrow_left_rounded,
            size: 18,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final _NavEntry entry;
  final bool selected;
  final bool collapsed;
  final VoidCallback onTap;

  const _NavItem({
    required this.entry,
    required this.selected,
    required this.collapsed,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    final collapsed = widget.collapsed;
    final label = tr(widget.entry.labelKey);

    final Color fg = selected
        ? AppColors.primary
        : Colors.white.withValues(alpha: _hovered ? 0.95 : 0.72);
    final Color bg = selected
        ? Colors.white
        : _hovered
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.transparent;

    final item = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          height: 46,
          padding: EdgeInsets.symmetric(horizontal: collapsed ? 0 : 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment:
                collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primarySoft : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  selected ? widget.entry.activeIcon : widget.entry.icon,
                  size: 19,
                  color: fg,
                ),
              ),
              if (!collapsed) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: (selected ? AppText.bodyStrong : AppText.bodyMedium)
                        .copyWith(
                      color: selected
                          ? AppColors.ink
                          : Colors.white
                              .withValues(alpha: _hovered ? 0.95 : 0.78),
                    ),
                  ),
                ),
                if (selected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.gold,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );

    if (!collapsed) return item;
    return Tooltip(
      message: label,
      preferBelow: false,
      waitDuration: const Duration(milliseconds: 300),
      child: item,
    );
  }
}

// ---------------- Yuqori panel elementlari ----------------

/// Joriy sana va soat (har daqiqada yangilanadi)
class _ClockChip extends StatefulWidget {
  const _ClockChip();

  @override
  State<_ClockChip> createState() => _ClockChipState();
}

class _ClockChipState extends State<_ClockChip> {
  late DateTime _now = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 20), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.calendar_month_rounded,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(DateFormat('dd.MM.yyyy').format(_now), style: AppText.label),
          Container(
            width: 1,
            height: 16,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColors.border,
          ),
          const Icon(
            Icons.schedule_rounded,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(DateFormat('HH:mm').format(_now), style: AppText.label),
        ],
      ),
    );
  }
}

class _TopBarButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final String? tooltip;

  const _TopBarButton({required this.child, required this.onTap, this.tooltip});

  @override
  State<_TopBarButton> createState() => _TopBarButtonState();
}

class _TopBarButtonState extends State<_TopBarButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final button = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceSunken : AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? AppColors.borderStrong : AppColors.border,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
    if (widget.tooltip == null) return button;
    return Tooltip(message: widget.tooltip!, child: button);
  }
}
