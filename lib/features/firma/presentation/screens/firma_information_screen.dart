import 'package:baraka_pos/shared/aplication/configs/di/injection_container.dart';
import 'package:baraka_pos/features/store/presentation/blocs/blocs.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/blocs.dart';
import '../widgets/firma_info_card.dart';
import 'debt_tab.dart';
import 'product_tab.dart';

class FirmaInformationScreen extends StatefulWidget {
  final int firmaId;
  final num remainder;

  const FirmaInformationScreen({
    super.key,
    required this.firmaId,
    required this.remainder,
  });

  @override
  State<FirmaInformationScreen> createState() => _FirmaInformationScreenState();
}

class _FirmaInformationScreenState extends State<FirmaInformationScreen> {
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() => context
      .read<GetByIdFirmaBloc>()
      .add(GetByIdFirmaStarted(id: widget.firmaId));

  Future<void> _delete() async {
    if (widget.remainder != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("debt_alert_message".tr())),
      );
      return;
    }
    final confirmed = await showAppConfirm(
      context,
      title: "delete_firma".tr(),
      message: "delete_firma_confirmation".tr(),
      confirmLabel: tr("yes_delete"),
      danger: true,
    );
    if (confirmed && mounted) {
      context.read<DeleteFirmaBloc>().add(DeleteFirmaEvent(id: widget.firmaId));
    }
  }

  Widget _currentTab() => switch (currentTab) {
        // Ombor sahifasi bilan umumiy bloc ishlatilsa, ikkala ro'yxat
        // bir-birining natijasini ko'rsatib qo'yadi — firma uchun alohida
        0 => BlocProvider(
            create: (_) => AllProductBloc(repository: sl()),
            child: ProductTab(firmaId: widget.firmaId),
          ),
        1 => PaymentTab(firmaId: widget.firmaId),
        _ => DebtTab(firmaId: widget.firmaId),
      };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteFirmaBloc, DeleteFirmaState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("firma_deleted_successfully".tr())),
            );
            context.go("/firma");
          },
          failure: (error) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message))),
        );
      },
      builder: (context, state) {
        final mobile = context.isMobile;
        final tabs = _FirmaTabs(
          value: currentTab,
          onChanged: (i) => setState(() => currentTab = i),
          tabs: [
            (Icons.inventory_2_rounded, "products".tr()),
            (Icons.payments_rounded, "payment_history".tr()),
            (Icons.request_quote_rounded, "debts_section".tr()),
          ],
        );
        final toolbar = AppToolbar(
          leading: [
            AppButton.secondary(
              label: "back_to_firma".tr(),
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: () => context.go("/firma"),
            ),
          ],
          trailing: [
            AppIconButton(
              icon: Icons.autorenew_rounded,
              tooltip: tr("refresh"),
              onPressed: _refresh,
            ),
            AppButton.danger(
              label: "delete".tr(),
              icon: Icons.delete_forever_rounded,
              loading: state is DeleteFirmaPrepare,
              onPressed: _delete,
            ),
          ],
        );
        return AppPage(
          // Telefonda firma kartasi va tablar ham sarlavha bilan birga suriladi
          // Firma kartasi va tablar ro'yxat bilan birga suriladi
          toolbar: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              toolbar,
              SizedBox(height: mobile ? AppSpacing.sm : AppSpacing.lg),
              const FirmaInfoCard(),
              SizedBox(height: mobile ? AppSpacing.md : AppSpacing.xl),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: tabs,
              ),
            ],
          ),
          child: _currentTab(),
        );
      },
    );
  }
}

/// Ikonali tab paneli (pastki chiziq bilan)
class _FirmaTabs extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final List<(IconData, String)> tabs;

  const _FirmaTabs({
    required this.value,
    required this.onChanged,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++) _tab(i, tabs[i].$1, tabs[i].$2),
        ],
      ),
    );
  }

  Widget _tab(int index, IconData icon, String label) {
    final active = index == value;
    final color = active ? AppColors.primary : AppColors.textSecondary;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? AppColors.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: active ? AppColors.primarySoft : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 17, color: color),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: AppText.bodyMedium.copyWith(
                  color: active ? AppColors.ink : AppColors.textSecondary,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
