import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/expense_category_model.dart';
import '../blocs/expense_categories_cubit/expense_categories_cubit.dart';

void _snack(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));

/// Kategoriya nomini so'raydigan oyna
Future<String?> showExpenseCategoryTitleDialog(
  BuildContext context, {
  String? initial,
}) async {
  final ctrl = TextEditingController(text: initial ?? "");
  final formKey = GlobalKey<FormState>();
  final title = await showDialog<String>(
    context: context,
    builder: (dialogContext) {
      void submit() {
        if (!formKey.currentState!.validate()) return;
        Navigator.pop(dialogContext, ctrl.text.trim());
      }

      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    initial == null
                        ? tr("new_expense_category")
                        : tr("edit"),
                    style: AppText.h2,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: tr("expense_category_name"),
                    required: true,
                    hint: tr("expense_category_hint"),
                    controller: ctrl,
                    prefix: const Icon(Icons.folder_rounded, size: 18),
                    onSubmitted: (_) => submit(),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? tr("field_required")
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: AppSpacing.sm,
                    children: [
                      AppButton.secondary(
                        label: tr("cancel"),
                        onPressed: () => Navigator.pop(dialogContext),
                      ),
                      AppButton(
                        label: tr("save"),
                        icon: Icons.check_circle_rounded,
                        onPressed: submit,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  ctrl.dispose();
  return title;
}

/// Yangi kategoriya yaratadi; muvaffaqiyatli bo'lsa uni qaytaradi
Future<ExpenseCategoryModel?> createExpenseCategory(
    BuildContext context) async {
  final title = await showExpenseCategoryTitleDialog(context);
  if (title == null || !context.mounted) return null;
  final (created, error) =
      await context.read<ExpenseCategoriesCubit>().create(title);
  if (error != null && context.mounted) _snack(context, error);
  return created;
}

/// Kategoriyalarni boshqarish: qo'shish, nomini o'zgartirish, o'chirish
Future<void> showExpenseCategoriesManager(BuildContext context) {
  final cubit = context.read<ExpenseCategoriesCubit>()..loadIfNeeded();
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: cubit,
      child: const _CategoriesManager(),
    ),
  );
}

class _CategoriesManager extends StatelessWidget {
  const _CategoriesManager();

  Future<void> _rename(BuildContext context, ExpenseCategoryModel c) async {
    final title =
        await showExpenseCategoryTitleDialog(context, initial: c.title);
    if (title == null || title == c.title || !context.mounted) return;
    final error =
        await context.read<ExpenseCategoriesCubit>().rename(c.id, title);
    if (error != null && context.mounted) _snack(context, error);
  }

  Future<void> _delete(BuildContext context, ExpenseCategoryModel c) async {
    final confirmed = await showAppConfirm(
      context,
      title: tr("confirm_delete"),
      message: "${c.title}. ${tr("expense_category_delete_warning")}",
      confirmLabel: tr("yes_delete"),
      danger: true,
    );
    if (!confirmed || !context.mounted) return;
    final error = await context.read<ExpenseCategoriesCubit>().delete(c.id);
    if (error != null && context.mounted) _snack(context, error);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460, maxHeight: 560),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const AppSoftIcon(
                    icon: Icons.folder_copy_rounded,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(tr("expense_categories"), style: AppText.h2),
                  ),
                  AppIconButton(
                    icon: Icons.close_rounded,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Flexible(
                child: BlocBuilder<ExpenseCategoriesCubit,
                    ExpenseCategoriesModel?>(
                  builder: (context, data) {
                    final categories = data?.categories ?? const [];
                    if (data == null) return const AppLoading();
                    if (data.error != null) {
                      return _LoadError(
                        message: data.error!,
                        onRetry: () =>
                            context.read<ExpenseCategoriesCubit>().load(),
                      );
                    }
                    if (categories.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Text(
                          tr("no_expense_categories"),
                          textAlign: TextAlign.center,
                          style: AppText.small,
                        ),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, color: AppColors.border),
                      itemBuilder: (context, i) {
                        final c = categories[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.xs),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      c.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppText.bodyMedium,
                                    ),
                                    Text(
                                      "${tr("expenses_count", args: ["${c.expensesCount}"])}"
                                      " · ${formatCurrency(c.totalAmount.toString())}",
                                      style: AppText.small,
                                    ),
                                  ],
                                ),
                              ),
                              AppIconButton(
                                icon: Icons.edit_rounded,
                                tooltip: tr("edit"),
                                color: AppColors.info,
                                onPressed: () => _rename(context, c),
                              ),
                              AppIconButton(
                                icon: Icons.delete_rounded,
                                tooltip: tr("delete"),
                                color: AppColors.danger,
                                onPressed: () => _delete(context, c),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: tr("new_expense_category"),
                icon: Icons.create_new_folder_rounded,
                onPressed: () => createExpenseCategory(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Qisqa xato xabari: uzun texnik matn o'rniga tushunarli izoh
class _LoadError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _LoadError({required this.message, required this.onRetry});

  String get _text {
    // Server hali yangilanmagan — kategoriyalar manzili yo'q
    if (message.contains("404")) return tr("expense_categories_server_outdated");
    if (message.length > 160 || message.contains("status code")) {
      return tr("expense_categories_load_failed");
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        children: [
          const AppSoftIcon(
            icon: Icons.cloud_off_rounded,
            color: AppColors.danger,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(_text, textAlign: TextAlign.center, style: AppText.small),
          const SizedBox(height: AppSpacing.md),
          AppButton.secondary(
            label: tr("retry"),
            icon: Icons.refresh_rounded,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
