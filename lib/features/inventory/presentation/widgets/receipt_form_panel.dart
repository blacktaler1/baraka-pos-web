import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/domain/model/cash_product_model.dart';
import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../../../firma/firma.dart';
import '../../domain/domain.dart';
import '../blocs/blocs.dart';
import 'invoice_scan_section.dart';
import 'product_picker_field.dart';

Future<void> showReceiptFormPanel(BuildContext context) {
  return showAppSidePanel(
    context,
    width: AppSizes.sidePanelWidthWide,
    builder: (_) => const ReceiptFormPanel(),
  );
}

final _moneyFormatters = <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
  ThousandsSeparatorFormatter(),
];

final _quantityFormatters = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
];

class _ReceiptLine {
  final CashProductModel product;
  final TextEditingController quantity;
  final TextEditingController unitCost;
  final TextEditingController newPrice = TextEditingController();

  /// Qator nakladnoydan AI orqali qo'shilganmi
  final bool fromScan;

  _ReceiptLine(
    this.product, {
    double quantity = 1,
    double? cost,
    this.fromScan = false,
  })  : quantity = TextEditingController(text: _fmtQty(quantity)),
        unitCost = TextEditingController(
          text: formatCurrency(
              (cost ?? parseAmount(product.cost)).toStringAsFixed(0),
              withCurrency: false),
        );

  static String _fmtQty(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : "$v";

  double get total => parseAmount(quantity.text) * parseAmount(unitCost.text);

  void dispose() {
    quantity.dispose();
    unitCost.dispose();
    newPrice.dispose();
  }
}

class ReceiptFormPanel extends StatefulWidget {
  const ReceiptFormPanel({super.key});

  @override
  State<ReceiptFormPanel> createState() => _ReceiptFormPanelState();
}

class _ReceiptFormPanelState extends State<ReceiptFormPanel> {
  final _lines = <_ReceiptLine>[];
  final _paidCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  int? _firmaId;

  /// Oxirgi skanerlash natijasi va hali mahsulotga bog'lanmagan qatorlari
  InvoiceScanModel? _scan;
  final _unmatched = <InvoiceScanLineModel>[];

  @override
  void initState() {
    super.initState();
    context
        .read<GetFirmaBloc>()
        .add(GetFirmaStarted(search: '', cursor: '', pageSize: 0, debt: false));
  }

  @override
  void dispose() {
    for (final line in _lines) {
      line.dispose();
    }
    _paidCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  double get _total => _lines.fold(0, (sum, l) => sum + l.total);

  void _addProduct(
    CashProductModel product, {
    double quantity = 1,
    double? cost,
    bool fromScan = false,
  }) {
    final existing = _lines.where((l) => l.product.id == product.id);
    setState(() {
      if (existing.isNotEmpty) {
        final line = existing.first;
        line.quantity.text = _trim(parseAmount(line.quantity.text) + quantity);
      } else {
        _lines.add(_ReceiptLine(product,
            quantity: quantity, cost: cost, fromScan: fromScan));
      }
    });
  }

  void _addScannedLine(
    CashProductModel product, {
    required double quantity,
    required double cost,
  }) {
    _addProduct(
      product,
      quantity: quantity > 0 ? quantity : 1,
      cost: cost > 0 ? cost : null,
      fromScan: true,
    );
  }

  void _applyScan(InvoiceScanModel scan) {
    for (final line in scan.lines) {
      if (line.product != null) {
        _addScannedLine(line.product!,
            quantity: line.quantity, cost: line.unitCost);
      }
    }
    setState(() {
      _scan = scan;
      _unmatched
        ..clear()
        ..addAll(scan.lines.where((l) => l.product == null));
      if (_firmaId == null && scan.firmaId != 0) _firmaId = scan.firmaId;
      if (_noteCtrl.text.trim().isEmpty && scan.invoiceNumber.isNotEmpty) {
        _noteCtrl.text = [
          "${tr("invoice")} №${scan.invoiceNumber}",
          if (scan.invoiceDate.isNotEmpty) scan.invoiceDate,
        ].join(", ");
      }
    });
  }

  static String _trim(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : "$v";

  void _submit() {
    final items = [
      for (final l in _lines)
        if (parseAmount(l.quantity.text) > 0)
          StockLineInput(
            productId: l.product.id,
            quantity: parseAmount(l.quantity.text),
            unitCost: parseAmountInt(l.unitCost.text),
            newPrice: l.newPrice.text.trim().isEmpty
                ? null
                : parseAmountInt(l.newPrice.text),
          ),
    ];
    if (items.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr("add_products_first"))));
      return;
    }
    context.read<CreateReceiptBloc>().add(CreateReceiptStarted(
          firmaId: _firmaId ?? 0,
          paidAmount: parseAmountInt(_paidCtrl.text),
          note: _noteCtrl.text.trim(),
          items: items,
        ));
  }

  Widget _firmaDropdown() {
    return BlocBuilder<GetFirmaBloc, GetFirmaState>(
      builder: (context, state) {
        final firms = state.maybeWhen(
          success: (model) => model.results.models,
          orElse: () => <FirmaModel>[],
        );
        return AppDropdown<int>(
          label: tr("company"),
          hint: tr("select"),
          value: firms.any((f) => f.id == _firmaId) ? _firmaId : null,
          items: firms
              .map((f) => DropdownMenuItem(value: f.id, child: Text(f.title)))
              .toList(),
          onChanged: (v) => setState(() => _firmaId = v),
        );
      },
    );
  }

  Widget _lineRow(_ReceiptLine line) {
    Widget field(TextEditingController c, List<TextInputFormatter> f,
            {String? hint}) =>
        SizedBox(
          width: 110,
          child: AppTextField(
            controller: c,
            hint: hint,
            keyboardType: TextInputType.number,
            inputFormatters: f,
            onChanged: (_) => setState(() {}),
          ),
        );

    if (context.isMobile) return _mobileLineRow(line);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(line.product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.bodyStrong),
                    ),
                    if (line.fromScan) ...[
                      const SizedBox(width: AppSpacing.xxs),
                      Tooltip(
                        message: tr("scan_added"),
                        child: const Icon(Icons.auto_awesome_rounded,
                            size: 14, color: AppColors.info),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${tr("in_stock")}: ${parseAmount(line.product.stock)} · ${tr("sale_price")}: ${formatCurrency(line.product.price)}",
                  style: AppText.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          field(line.quantity, _quantityFormatters),
          const SizedBox(width: AppSpacing.xs),
          field(line.unitCost, _moneyFormatters),
          const SizedBox(width: AppSpacing.xs),
          field(line.newPrice, _moneyFormatters, hint: tr("optional")),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 120,
            child: Text(
              formatCurrency(line.total.toStringAsFixed(0)),
              textAlign: TextAlign.right,
              style: AppText.bodyStrong,
            ),
          ),
          AppIconButton(
            icon: Icons.close_rounded,
            tooltip: tr("delete"),
            color: AppColors.textTertiary,
            onPressed: () => setState(() {
              _lines.remove(line);
              line.dispose();
            }),
          ),
        ],
      ),
    );
  }

  /// Telefon: har bir qator — kichik kartochka, maydonlar yonma-yon teng
  Widget _mobileLineRow(_ReceiptLine line) {
    Widget field(
            String label, TextEditingController c, List<TextInputFormatter> f,
            {String? hint}) =>
        Expanded(
          child: AppTextField(
            label: label,
            controller: c,
            hint: hint,
            keyboardType: TextInputType.number,
            inputFormatters: f,
            onChanged: (_) => setState(() {}),
          ),
        );

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  line.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyStrong,
                ),
              ),
              if (line.fromScan)
                const Icon(Icons.auto_awesome_rounded,
                    size: 14, color: AppColors.info),
              AppIconButton(
                icon: Icons.close_rounded,
                tooltip: tr("delete"),
                color: AppColors.textTertiary,
                onPressed: () => setState(() {
                  _lines.remove(line);
                  line.dispose();
                }),
              ),
            ],
          ),
          Text(
            "${tr("in_stock")}: ${parseAmount(line.product.stock)} · ${tr("sale_price")}: ${formatCurrency(line.product.price)}",
            style: AppText.caption,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              field(tr("qty"), line.quantity, _quantityFormatters),
              const SizedBox(width: AppSpacing.xs),
              field(tr("cost_price"), line.unitCost, _moneyFormatters),
              const SizedBox(width: AppSpacing.xs),
              field(tr("new_sale_price"), line.newPrice, _moneyFormatters,
                  hint: tr("optional")),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            formatCurrency(line.total.toStringAsFixed(0)),
            textAlign: TextAlign.right,
            style: AppText.bodyStrong,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateReceiptBloc, CreateReceiptState>(
      listener: (context, state) => state.whenOrNull(
        success: (_) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(tr("receipt_saved"))));
        },
        failure: (error) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message))),
      ),
      builder: (context, state) => AppSidePanel(
        title: tr("new_receipt"),
        icon: Icons.move_to_inbox_rounded,
        iconColor: AppColors.success,
        subtitle: tr("new_receipt_hint"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InvoiceScanCard(onScanned: _applyScan),
            if (_scan != null) ...[
              const SizedBox(height: AppSpacing.sm),
              InvoiceScanSummary(scan: _scan!, formTotal: _total),
            ],
            const SizedBox(height: AppSpacing.lg),
            AppFormRow(children: [
              _firmaDropdown(),
              AppTextField(label: tr("note"), controller: _noteCtrl),
            ]),
            const SizedBox(height: AppSpacing.xl),
            AppSectionHeader(
              title: tr("products"),
              trailing: AppBadge("${_lines.length}", tone: AppTone.primary),
            ),
            const SizedBox(height: AppSpacing.sm),
            ProductPickerField(onSelected: (p) => _addProduct(p)),
            const SizedBox(height: AppSpacing.sm),
            if (_unmatched.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.link_off_rounded,
                      size: 16, color: AppColors.warning),
                  const SizedBox(width: AppSpacing.xxs),
                  Text(
                    tr("scan_unmatched", args: ["${_unmatched.length}"]),
                    style: AppText.label.copyWith(color: AppColors.warning),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              for (final line in List.of(_unmatched))
                UnmatchedInvoiceLine(
                  key: ObjectKey(line),
                  line: line,
                  firmaId: _firmaId,
                  onAssign: (product, quantity, cost) {
                    _addScannedLine(product, quantity: quantity, cost: cost);
                    setState(() => _unmatched.remove(line));
                  },
                  onSkip: () => setState(() => _unmatched.remove(line)),
                ),
              const SizedBox(height: AppSpacing.sm),
            ],
            if (_lines.isNotEmpty && !context.isMobile)
              Row(
                children: [
                  Expanded(child: Text(tr("products"), style: AppText.caption)),
                  SizedBox(
                      width: 110,
                      child: Text(tr("qty"), style: AppText.caption)),
                  const SizedBox(width: AppSpacing.xs),
                  SizedBox(
                      width: 110,
                      child: Text(tr("cost_price"), style: AppText.caption)),
                  const SizedBox(width: AppSpacing.xs),
                  SizedBox(
                      width: 110,
                      child:
                          Text(tr("new_sale_price"), style: AppText.caption)),
                  const SizedBox(width: AppSpacing.sm + 120 + 40),
                ],
              ),
            for (final line in _lines) _lineRow(line),
            if (_lines.isEmpty)
              EmptyState(
                icon: Icons.inventory_2_rounded,
                message: tr("add_products_first"),
              ),
            const SizedBox(height: AppSpacing.xl),
            AppTotalBar(
              label: tr("grand_total"),
              value: formatCurrency(_total.toStringAsFixed(0)),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: tr("paid_amount"),
              helper: _firmaId == null
                  ? tr("paid_amount_hint_no_firma")
                  : tr("paid_amount_hint"),
              controller: _paidCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: _moneyFormatters,
            ),
          ],
        ),
        actions: [
          AppButton.secondary(
            label: tr("cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          AppButton(
            label: tr("save"),
            icon: Icons.check_circle_rounded,
            loading: state is CreateReceiptPrepare,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
