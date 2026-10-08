import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:baraka_pos/shared/aplication/utils/excel_file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/domain/model/cash_product_model.dart';
import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../../../global/domain/domain.dart';
import '../../../store/presentation/screens/create_product_screen.dart';
import '../../domain/domain.dart';
import '../blocs/blocs.dart';
import 'product_picker_field.dart';

/// Kirim formasining tepasidagi "Nakladnoyni skanerlash" kartasi
class InvoiceScanCard extends StatelessWidget {
  final ValueChanged<InvoiceScanModel> onScanned;

  const InvoiceScanCard({super.key, required this.onScanned});

  Future<void> _pick(BuildContext context) async {
    final bloc = context.read<ScanInvoiceBloc>();
    // Telefonda bu yerda kamera bilan suratga olish ham taklif qilinadi
    final file =
        await pickSingleFile(const ['jpg', 'jpeg', 'png', 'webp', 'pdf']);
    if (file != null) bloc.add(ScanInvoiceStarted(file: file));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScanInvoiceBloc, ScanInvoiceState>(
      listener: (context, state) => state.whenOrNull(
        success: onScanned,
        failure: (error) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${tr("scan_failed")}: ${error.message}")),
        ),
      ),
      builder: (context, state) {
        final loading = state is ScanInvoicePrepare;
        final pickButton = AppButton(
          label: tr("choose_file"),
          icon: context.isMobile
              ? Icons.photo_camera_rounded
              : Icons.upload_file_rounded,
          loading: loading,
          expand: context.isMobile,
          onPressed: () => _pick(context),
        );
        final card = Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.info.withValues(alpha: 0.10),
                AppColors.primary.withValues(alpha: 0.06),
              ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.info.withValues(alpha: 0.18)),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2B86C5), Color(0xFF17694F)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: loading
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.document_scanner_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(tr("scan_invoice"), style: AppText.h3),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const AppBadge(
                          "AI",
                          tone: AppTone.info,
                          icon: Icons.auto_awesome_rounded,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      loading ? tr("scan_reading") : tr("scan_invoice_hint"),
                      style: AppText.small,
                    ),
                  ],
                ),
              ),
              if (!context.isMobile) ...[
                const SizedBox(width: AppSpacing.sm),
                pickButton,
              ],
            ],
          ),
        );
        if (!context.isMobile) return card;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [card, const SizedBox(height: AppSpacing.xs), pickButton],
        );
      },
    );
  }
}

/// AI natijasi haqida qisqa xulosa: nechta qator topildi, jami summa mosligi
class InvoiceScanSummary extends StatelessWidget {
  final InvoiceScanModel scan;
  final double formTotal;

  const InvoiceScanSummary({
    super.key,
    required this.scan,
    required this.formTotal,
  });

  @override
  Widget build(BuildContext context) {
    final matched = scan.lines.where((l) => l.product != null).length;
    final doc = scan.documentTotal;
    // Nakladnoydagi jami bilan formadagi jami 1% dan ko'p farq qilsa — ogohlantiramiz
    final mismatch = doc > 0 && (formTotal - doc).abs() > doc * 0.01;

    final parts = [
      if (scan.invoiceNumber.isNotEmpty) "№${scan.invoiceNumber}",
      if (scan.invoiceDate.isNotEmpty) scan.invoiceDate,
      if (scan.supplierName.isNotEmpty) scan.supplierName,
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: mismatch ? AppColors.warningSoft : AppColors.successSoft,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(
            mismatch ? Icons.warning_amber_rounded : Icons.task_alt_rounded,
            size: 20,
            color: mismatch ? AppColors.warning : AppColors.success,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("scan_result", args: [
                    "${scan.lines.length}",
                    "$matched",
                  ]),
                  style: AppText.bodyStrong,
                ),
                if (parts.isNotEmpty)
                  Text(parts.join(" · "), style: AppText.caption),
                if (mismatch)
                  Text(
                    tr("scan_total_mismatch", args: [
                      formatCurrency(doc.toStringAsFixed(0)),
                    ]),
                    style: AppText.caption.copyWith(color: AppColors.warning),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ProductModel (yaratilgan mahsulot) → kassa/kirim formasidagi CashProductModel
CashProductModel cashProductFrom(ProductModel p) => CashProductModel(
      id: p.id,
      title: p.title,
      cost: p.cost,
      price: p.price,
      wholesalePrice: p.wholesalePrice,
      stock: p.stock,
      categoryTitle: p.category.title,
      unit: p.unit,
      packSize: p.packSize,
      qrcode: p.qrCode,
      warehouse: p.warehouseId,
      images: p.imageCollection.models.lastOrNull?.file ?? "",
    );

/// Nakladnoydagi birlikni ilovadagi birlikka o'girish (шт → dona, кг → kg ...)
String appUnitFrom(String raw) {
  final u = raw.toLowerCase().replaceAll(".", "").trim();
  if (["шт", "штук", "dona", "ta", "pcs", "шт."].contains(u)) return "dona";
  if (["кг", "kg"].contains(u)) return "kg";
  if (["л", "l", "литр", "litr"].contains(u)) return "litr";
  if (["м", "m", "метр", "metr"].contains(u)) return "metr";
  return "";
}

/// Ombordagi mahsulotga avtomatik moslanmagan nakladnoy qatori.
/// Soni va narxini tahrirlab, mavjud mahsulotga ulash yoki yangisini yaratish mumkin.
class UnmatchedInvoiceLine extends StatefulWidget {
  final InvoiceScanLineModel line;
  final int? firmaId;
  final void Function(CashProductModel product, double quantity, double cost)
      onAssign;
  final VoidCallback onSkip;

  const UnmatchedInvoiceLine({
    super.key,
    required this.line,
    required this.firmaId,
    required this.onAssign,
    required this.onSkip,
  });

  @override
  State<UnmatchedInvoiceLine> createState() => _UnmatchedInvoiceLineState();
}

class _UnmatchedInvoiceLineState extends State<UnmatchedInvoiceLine> {
  late final _qty = TextEditingController(text: _fmtQty(widget.line.quantity));
  late final _cost = TextEditingController(
    text: widget.line.unitCost > 0
        ? formatCurrency(widget.line.unitCost.toStringAsFixed(0),
            withCurrency: false)
        : "",
  );

  static String _fmtQty(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  @override
  void dispose() {
    _qty.dispose();
    _cost.dispose();
    super.dispose();
  }

  double get _quantity => parseAmount(_qty.text);
  double get _unitCost => parseAmount(_cost.text);

  void _assign(CashProductModel product) =>
      widget.onAssign(product, _quantity, _unitCost);

  Future<void> _createNew() async {
    final created = await showCreateProductPanel(
      context,
      firmaId: widget.firmaId,
      draft: ProductDraft(
        title: widget.line.name,
        cost: _unitCost,
        barcode: widget.line.barcode,
        unit: appUnitFrom(widget.line.unit),
      ),
    );
    if (created != null && mounted) _assign(cashProductFrom(created));
  }

  @override
  Widget build(BuildContext context) {
    final line = widget.line;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.isMobile)
            _mobileHeader(line)
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.help_outline_rounded,
                      size: 18, color: AppColors.warning),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      line.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyStrong,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                SizedBox(
                  width: 90,
                  child: AppTextField(
                    controller: _qty,
                    hint: tr("qty"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    suffix: _suffix(line.unit),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                SizedBox(
                  width: 130,
                  child: AppTextField(
                    controller: _cost,
                    hint: tr("cost_price"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ThousandsSeparatorFormatter(),
                    ],
                  ),
                ),
                AppIconButton(
                  icon: Icons.close_rounded,
                  tooltip: tr("skip"),
                  color: AppColors.textTertiary,
                  onPressed: widget.onSkip,
                ),
              ],
            ),
          if (line.candidates.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xxs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(tr("scan_maybe"), style: AppText.caption),
                for (final c in line.candidates)
                  ActionChip(
                    avatar: const Icon(Icons.add_rounded,
                        size: 16, color: AppColors.primary),
                    label: Text(c.title),
                    onPressed: () => _assign(c),
                  ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.xs),
          if (context.isMobile) ...[
            ProductPickerField(onSelected: _assign),
            const SizedBox(height: AppSpacing.xs),
            AppButton.secondary(
              label: tr("create_new_product"),
              icon: Icons.add_box_rounded,
              expand: true,
              onPressed: _createNew,
            ),
          ] else
            Row(
              children: [
                Expanded(child: ProductPickerField(onSelected: _assign)),
                const SizedBox(width: AppSpacing.xs),
                AppButton(
                  label: tr("create_new_product"),
                  icon: Icons.add_box_rounded,
                  onPressed: _createNew,
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// Telefon: nomi tepada, miqdor va tannarx ostida teng bo'lib
  Widget _mobileHeader(dynamic line) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.help_outline_rounded,
                size: 18, color: AppColors.warning),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                line.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppText.bodyStrong,
              ),
            ),
            AppIconButton(
              icon: Icons.close_rounded,
              tooltip: tr("skip"),
              color: AppColors.textTertiary,
              onPressed: widget.onSkip,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _qty,
                hint: tr("qty"),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                suffix: _suffix(line.unit),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: AppTextField(
                controller: _cost,
                hint: tr("cost_price"),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorFormatter(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget? _suffix(String unit) => unit.isEmpty
      ? null
      : Padding(
          padding: const EdgeInsets.only(right: AppSpacing.xs),
          child: Center(
            widthFactor: 1,
            child: Text(unit, style: AppText.caption),
          ),
        );
}
