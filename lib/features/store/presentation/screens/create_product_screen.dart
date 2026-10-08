import 'package:baraka_pos/shared/aplication/utils/unit_utils.dart';
import 'package:cross_file/cross_file.dart';

import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/blocs/cash_product_bloc/cash_product_bloc.dart';
import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../../../firma/firma.dart';
import '../../../global/global.dart';
import '../../../media/media.dart';
import '../presentation.dart';

/// Nakladnoydan yangi mahsulot yaratishda formani oldindan to'ldirish uchun
class ProductDraft {
  final String title;
  final double cost;
  final String barcode;
  final String unit;

  const ProductDraft({
    required this.title,
    required this.cost,
    this.barcode = "",
    this.unit = "",
  });
}

/// Yaratilgan mahsulotni qaytaradi (bekor qilinsa — null).
/// [draft] berilsa, zaxira 0 bo'ladi: u keyin kirim orqali qo'shiladi.
Future<ProductModel?> showCreateProductPanel(
  BuildContext context, {
  int? firmaId,
  ProductDraft? draft,
}) {
  return showAppSidePanel<ProductModel>(
    context,
    width: AppSizes.sidePanelWidthWide,
    builder: (_) => CreateProductPanel(firmaId: firmaId, draft: draft),
  );
}

class CreateProductPanel extends StatefulWidget {
  final int? firmaId;
  final ProductDraft? draft;

  const CreateProductPanel({super.key, this.firmaId, this.draft});

  @override
  State<CreateProductPanel> createState() => _CreateProductPanelState();
}

class _CreateProductPanelState extends State<CreateProductPanel> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _cost = TextEditingController();
  final _price = TextEditingController();
  final _stock = TextEditingController();
  final _sku = TextEditingController();
  final _packStock = TextEditingController();
  final _wholesale = TextEditingController();
  final _minStock = TextEditingController();
  final _meterPrice = TextEditingController();

  List<int> _imageIds = [];
  String? _suggestedImageUrl;
  XFile? _pickedImage;
  bool _uploading = false;

  String? _unit;
  int? _categoryId;
  late int? _firmaId = widget.firmaId;
  bool _showSuggestions = false;

  static final _moneyFormatters = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    ThousandsSeparatorFormatter(),
  ];

  /// Kirimdan ochilgan — zaxirani qo'lda kiritib bo'lmaydi
  bool get _fromReceipt => widget.draft != null;

  @override
  void initState() {
    super.initState();
    final draft = widget.draft;
    if (draft != null) {
      _name.text = draft.title;
      if (draft.cost > 0) {
        _cost.text =
            formatCurrency(draft.cost.toStringAsFixed(0), withCurrency: false);
      }
      _sku.text = draft.barcode;
      _stock.text = "0";
      if (productUnits.contains(draft.unit)) _unit = draft.unit;
    }
    context
        .read<GetCategoryBloc>()
        .add(GetCategoryStarted(cursor: "", pageSize: "all"));
    context
        .read<GetFirmaBloc>()
        .add(GetFirmaStarted(search: '', cursor: '', pageSize: 0, debt: false));
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _cost,
      _price,
      _stock,
      _sku,
      _packStock,
      _wholesale,
      _minStock,
      _meterPrice,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _requiredText(String? v, String key) =>
      (v == null || v.trim().isEmpty) ? tr(key) : null;

  void _snack(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<CreateProductBloc>().add(
          CreateProductStarted(
            title: _name.text,
            cost: parseAmountInt(_cost.text),
            price: parseAmountInt(_price.text),
            stock: parseAmount(_stock.text),
            categoryId: _categoryId ?? 0,
            unit: _unit ?? "",
            packSize: parseAmountInt(_packStock.text),
            imagesIds: _imageIds,
            qrCode: _sku.text,
            firmaId: _firmaId ?? 0,
            wholesalePrice: _wholesale.text.trim().isEmpty
                ? null
                : parseAmountInt(_wholesale.text),
            minStock: _minStock.text.trim().isEmpty
                ? null
                : parseAmount(_minStock.text),
            meterPrice: _unit == "roll" && _meterPrice.text.trim().isNotEmpty
                ? parseAmountInt(_meterPrice.text)
                : null,
          ),
        );
  }

  void _onNameChanged(String value) {
    final show = value.length > 2;
    setState(() => _showSuggestions = show);
    if (show) {
      context
          .read<GlobalProductSearchBloc>()
          .add(GlobalProductSearchEvent(search: value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostMediaBloc, PostMediaState>(
          listener: (context, state) {
            state.whenOrNull(
              inPrepare: () => setState(() => _uploading = true),
              success: (model) => setState(() {
                _uploading = false;
                _imageIds = [model.id];
              }),
              failure: (err) {
                setState(() => _uploading = false);
                _snack(err.message);
              },
            );
          },
        ),
        BlocListener<CreateProductBloc, CreateProductState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (product) {
                context.read<AllProductBloc>().add(
                      AllProductEvent(
                        search: '',
                        cursor: '',
                        pageSize: 0,
                        firmaId: widget.firmaId ?? 0,
                        category: '',
                        lowStock: false,
                      ),
                    );
                context.read<CashProductBloc>().add(
                      CashProductStarted(
                        search: "",
                        cursor: "",
                        pageSize: "all",
                        category: "",
                      ),
                    );
                Navigator.pop(context, product);
                _snack(tr("product_created"));
              },
              failure: (err) => _snack(err.message),
            );
          },
        ),
      ],
      child: BlocBuilder<CreateProductBloc, CreateProductState>(
        builder: (context, state) {
          return AppSidePanel(
            title: tr("add_product"),
            icon: Icons.add_box_rounded,
            iconColor: AppColors.primary,
            subtitle: tr("product_information"),
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppFormSection(
                    title: tr("basic_info"),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppImagePicker(
                            size: 112,
                            file: _pickedImage,
                            imageUrl: _suggestedImageUrl,
                            uploading: _uploading,
                            onPicked: (file) {
                              setState(() => _pickedImage = file);
                              context
                                  .read<PostMediaBloc>()
                                  .add(PostMediaStarted(image: file));
                            },
                          ),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppTextField(
                                  label: tr("product_name"),
                                  required: true,
                                  controller: _name,
                                  onChanged: _onNameChanged,
                                  validator: (v) =>
                                      _requiredText(v, "product_name_required"),
                                ),
                                if (_showSuggestions) _suggestions(),
                                const AppFormGap(),
                                _skuField(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppFormSection(
                    title: tr("pricing"),
                    children: [
                      AppFormRow(children: [
                        AppTextField(
                          label: tr("cost_price"),
                          required: true,
                          controller: _cost,
                          keyboardType: TextInputType.number,
                          inputFormatters: _moneyFormatters,
                          validator: (v) => _requiredText(v, "required"),
                        ),
                        AppTextField(
                          label: tr("sale_price"),
                          required: true,
                          controller: _price,
                          keyboardType: TextInputType.number,
                          inputFormatters: _moneyFormatters,
                          validator: (v) => _requiredText(v, "required"),
                        ),
                      ]),
                      AppTextField(
                        label: tr("wholesale_price"),
                        helper: tr("wholesale_price_hint"),
                        controller: _wholesale,
                        keyboardType: TextInputType.number,
                        inputFormatters: _moneyFormatters,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppFormSection(
                    title: tr("stock_and_unit"),
                    children: [
                      AppFormRow(children: [
                        AppTextField(
                          label: tr("stock"),
                          required: true,
                          controller: _stock,
                          readOnly: _fromReceipt,
                          helper: _fromReceipt
                              ? tr("stock_from_receipt_hint")
                              : null,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.,]')),
                          ],
                          validator: (v) => _requiredText(v, "stock_required"),
                        ),
                        AppDropdown<String>(
                          label: tr("unit"),
                          required: true,
                          hint: tr("select"),
                          value: _unit,
                          items: [
                            for (final u in productUnits)
                              DropdownMenuItem(
                                value: u,
                                child: Text(unitLabel(u)),
                              ),
                          ],
                          onChanged: (v) => setState(() => _unit = v),
                          validator: (v) => v == null ? tr("required") : null,
                        ),
                      ]),
                      if (_unit == "pack" || _unit == "roll")
                        AppTextField(
                          label: _unit == "roll"
                              ? tr("meters_in_piece")
                              : "${tr("pack")} ${tr("stock")}",
                          helper:
                              _unit == "roll" ? tr("roll_stock_hint") : null,
                          required: true,
                          controller: _packStock,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (v) => _requiredText(v, "stock_required"),
                        ),
                      if (_unit == "roll")
                        AppTextField(
                          label: tr("meter_price"),
                          helper: tr("meter_price_hint"),
                          controller: _meterPrice,
                          keyboardType: TextInputType.number,
                          inputFormatters: _moneyFormatters,
                        ),
                      AppTextField(
                        label: tr("min_stock"),
                        helper: tr("min_stock_hint"),
                        controller: _minStock,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppFormSection(
                    title: tr("classification"),
                    children: [
                      AppFormRow(children: [
                        _categoryDropdown(),
                        _firmaDropdown(),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              AppButton.secondary(
                label: tr("cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              AppButton(
                label: tr("add_product"),
                loading: state is CreateProductPrepare,
                onPressed: _uploading ? null : _submit,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _skuField() {
    return BlocConsumer<GeneratedCodeBloc, GeneratedCodeState>(
      listener: (context, state) {
        state.whenOrNull(success: (model) => _sku.text = model.generatedCode);
      },
      builder: (context, state) {
        final generating = state.maybeWhen(
          inPrepare: () => true,
          orElse: () => false,
        );
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: AppTextField(
                label: tr("sku"),
                required: true,
                controller: _sku,
                validator: (v) => _requiredText(v, "sku_required"),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            AppButton.secondary(
              label: tr("generate"),
              icon: Icons.auto_awesome_rounded,
              loading: generating,
              onPressed: () =>
                  context.read<GeneratedCodeBloc>().add(GeneratedCodeStarted()),
            ),
          ],
        );
      },
    );
  }

  Widget _suggestions() {
    return BlocBuilder<GlobalProductSearchBloc, GlobalProductSearchState>(
      builder: (context, state) {
        return state.maybeWhen(
          inPrepare: () => const Padding(
            padding: EdgeInsets.only(top: AppSpacing.xs),
            child: LinearProgressIndicator(),
          ),
          success: (model) {
            final items = model.result.models;
            return Container(
              margin: const EdgeInsets.only(top: AppSpacing.xs),
              constraints: const BoxConstraints(maxHeight: 260),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.control,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.sm, AppSpacing.xxs, AppSpacing.xxs, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            items.isEmpty
                                ? tr("product_not_found")
                                : tr("search_results"),
                            style: AppText.caption,
                          ),
                        ),
                        AppIconButton(
                          icon: Icons.close_rounded,
                          onPressed: () =>
                              setState(() => _showSuggestions = false),
                        ),
                      ],
                    ),
                  ),
                  if (items.isNotEmpty)
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final product = items[index];
                          final url = product.images.models.isNotEmpty
                              ? product.images.models.first.file
                              : null;
                          return ListTile(
                            dense: true,
                            leading: AppAvatar(
                              name: product.title,
                              imageUrl: url,
                            ),
                            title:
                                Text(product.title, style: AppText.bodyMedium),
                            subtitle: Text(
                              "SKU: ${product.qrCode} · ${product.unit}",
                              style: AppText.caption,
                            ),
                            onTap: () {
                              _name.text = product.title;
                              _sku.text = product.qrCode;
                              setState(() {
                                _unit = productUnits.contains(product.unit)
                                    ? product.unit
                                    : _unit;
                                _imageIds = product.images.models
                                    .map((e) => e.id)
                                    .toList();
                                _suggestedImageUrl = url;
                                _pickedImage = null;
                                _showSuggestions = false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _categoryDropdown() {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        final categories = state.maybeWhen(
          success: (model) => model.collection.models,
          orElse: () => <CategoryModel>[],
        );
        return AppDropdown<int>(
          label: tr("category"),
          required: true,
          hint: tr("select_category"),
          value: _categoryId,
          items: categories
              .map((c) => DropdownMenuItem(value: c.id, child: Text(c.title)))
              .toList(),
          onChanged: (v) => setState(() => _categoryId = v),
          validator: (v) => v == null ? tr("required") : null,
        );
      },
    );
  }

  Widget _firmaDropdown() {
    return BlocBuilder<GetFirmaBloc, GetFirmaState>(
      builder: (context, state) {
        final firms = state.maybeWhen(
          success: (model) => model.results.models,
          orElse: () => <FirmaModel>[],
        );
        final safeValue = firms.any((f) => f.id == _firmaId) ? _firmaId : null;
        return AppDropdown<int>(
          label: tr("company"),
          hint: tr("select"),
          value: safeValue,
          items: firms
              .map((f) => DropdownMenuItem(value: f.id, child: Text(f.title)))
              .toList(),
          onChanged: (v) => setState(() => _firmaId = v),
        );
      },
    );
  }
}
