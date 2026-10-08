import 'package:baraka_pos/shared/aplication/utils/excel_file_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class ProductExcelActions extends StatelessWidget {
  final VoidCallback onImported;

  const ProductExcelActions({super.key, required this.onImported});

  void _snack(BuildContext context, String message) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

  Future<void> _import(BuildContext context) async {
    final bloc = context.read<ImportProductsBloc>();
    final file = await pickExcelFile();
    if (file != null) bloc.add(ImportProductsStarted(file: file));
  }

  void _showImportErrors(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(tr("import_failed")),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(child: SelectableText(message)),
        ),
        actions: [
          AppButton(
            label: tr("ok"),
            onPressed: () => Navigator.pop(dialogContext),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ExportProductsBloc, ExportProductsState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (file) async {
                final path = await saveExcelFile(file.bytes, "products.xlsx");
                if (path != null && context.mounted) {
                  _snack(context, tr("file_saved"));
                }
              },
              failure: (error) => _snack(context, error.message),
            );
          },
        ),
        BlocListener<ImportProductsBloc, ImportProductsState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (result) {
                _snack(
                  context,
                  tr("import_result", args: [
                    "${result.created}",
                    "${result.updated}",
                  ]),
                );
                onImported();
              },
              failure: (error) => _showImportErrors(context, error.message),
            );
          },
        ),
      ],
      child: context.isMobile
          ? _mobileMenu(context)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<ImportProductsBloc, ImportProductsState>(
                  builder: (context, state) => AppButton.secondary(
                    label: tr("import_excel"),
                    icon: Icons.drive_folder_upload_rounded,
                    loading: state is ImportProductsPrepare,
                    onPressed: () => _import(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                BlocBuilder<ExportProductsBloc, ExportProductsState>(
                  builder: (context, state) => AppButton.secondary(
                    label: tr("export_excel"),
                    icon: Icons.sim_card_download_rounded,
                    loading: state is ExportProductsPrepare,
                    onPressed: () => context
                        .read<ExportProductsBloc>()
                        .add(const ExportProductsStarted()),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _mobileMenu(BuildContext context) {
    final importing =
        context.watch<ImportProductsBloc>().state is ImportProductsPrepare;
    final exporting =
        context.watch<ExportProductsBloc>().state is ExportProductsPrepare;
    return PopupMenuButton<String>(
      tooltip: "Excel",
      onSelected: (v) {
        if (v == 'import') _import(context);
        if (v == 'export') {
          context.read<ExportProductsBloc>().add(const ExportProductsStarted());
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'import',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.drive_folder_upload_rounded),
            title: Text(tr("import_excel")),
          ),
        ),
        PopupMenuItem(
          value: 'export',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.sim_card_download_rounded),
            title: Text(tr("export_excel")),
          ),
        ),
      ],
      child: Container(
        height: AppSizes.controlHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.control,
          border: Border.all(color: AppColors.borderStrong),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (importing || exporting)
              const SizedBox.square(
                dimension: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              const Icon(Icons.table_view_rounded,
                  size: 18, color: AppColors.success),
            const SizedBox(width: 6),
            Text("Excel", style: AppText.bodyStrong),
            const Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
    );
  }
}
