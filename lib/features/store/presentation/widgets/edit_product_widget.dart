import 'package:baraka_pos/shared/aplication/utils/unit_utils.dart';
import 'package:cross_file/cross_file.dart';

import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../../cash/presentation/blocs/cash_product_bloc/cash_product_bloc.dart';
import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../../../firma/firma.dart';
import '../../../global/global.dart';
import '../../../media/presentation/blocs/post_media_bloc/post_media_bloc.dart';
import '../blocs/blocs.dart';

const productUnits = ["kg", "dona", "litr", "metr", "pack", "roll"];

Future<void> showEditProductPanel(
  BuildContext context, {
  required ProductModel product,
  int firmaId = 0,
}) {
  return showAppSidePanel(
    context,
    width: AppSizes.sidePanelWidthWide,
    builder: (_) => EditProductModal(product: product, firmaId: firmaId),
  );
}

class EditProductModal extends StatefulWidget {
  final ProductModel product;
  final int firmaId;

  const EditProductModal({super.key, required this.product, this.firmaId = 0});

  @override
  State<EditProductModal> createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  late final titleCtrl = TextEditingController(text: widget.product.title);
  late final priceCtrl = TextEditingController(
    text: formatCurrency(
      double.parse(widget.product.price).toInt().toString(),
      withCurrency: false,
    ),
  );
  late final costCtrl = TextEditingController(
    text: formatCurrency(
      double.parse(widget.product.cost).toInt().toString(),
      withCurrency: false,
    ),
  );
  late final stockCtrl =
      TextEditingController(text: widget.product.stock.toString());
  late final qrCodeCtrl = TextEditingController(text: widget.product.qrCode);
  late final packCtrl =
      TextEditingController(text: widget.product.packSize.toString());
  late final wholesaleCtrl = TextEditingController(
    text: _originalWholesale == null
        ? ""
        : formatCurrency("$_originalWholesale", withCurrency: false),
  );
  late final meterPriceCtrl = TextEditingController(
    text: _originalMeterPrice == null
        ? ""
        : formatCurrency("$_originalMeterPrice", withCurrency: false),
  );
  late final minStockCtrl = TextEditingController(
    text: _originalMinStock == null ? "" : _trimZeros(_originalMinStock!),
  );

  int? get _originalWholesale => widget.product.wholesalePrice.isEmpty
      ? null
      : parseAmount(widget.product.wholesalePrice).round();

  int? get _originalMeterPrice => widget.product.meterPrice.isEmpty
      ? null
      : parseAmount(widget.product.meterPrice).round();

  int? get _meterPriceValue => meterPriceCtrl.text.trim().isEmpty
      ? null
      : parseAmountInt(meterPriceCtrl.text);

  double? get _originalMinStock => widget.product.minStock.isEmpty
      ? null
      : parseAmount(widget.product.minStock);

  int? get _wholesaleValue => wholesaleCtrl.text.trim().isEmpty
      ? null
      : parseAmountInt(wholesaleCtrl.text);

  double? get _minStockValue =>
      minStockCtrl.text.trim().isEmpty ? null : parseAmount(minStockCtrl.text);

  static String _trimZeros(double value) =>
      value == value.roundToDouble() ? value.toInt().toString() : "$value";

  late String? selectedUnit = widget.product.unit;
  late int? selectedCategoryId = widget.product.category.id;
  late int? selectedFirmaId = widget.product.firma?.id;

  XFile? pickedImage;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    context
        .read<GetCategoryBloc>()
        .add(GetCategoryStarted(cursor: "", pageSize: "all"));
    context
        .read<GetFirmaBloc>()
        .add(GetFirmaStarted(search: '', cursor: '', pageSize: 0, debt: false));
    for (final c in [
      titleCtrl,
      priceCtrl,
      costCtrl,
      stockCtrl,
      qrCodeCtrl,
      packCtrl,
      wholesaleCtrl,
      minStockCtrl,
      meterPriceCtrl,
    ]) {
      c.addListener(checkChanges);
    }
  }

  @override
  void dispose() {
    for (final c in [
      titleCtrl,
      priceCtrl,
      costCtrl,
      stockCtrl,
      qrCodeCtrl,
      packCtrl,
      wholesaleCtrl,
      minStockCtrl,
      meterPriceCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void checkChanges() {
    final p = widget.product;
    final currentPrice = priceCtrl.text.trim().replaceAll(' ', '');
    final currentCost = costCtrl.text.trim().replaceAll(' ', '');

    final changed = titleCtrl.text.trim() != p.title ||
        currentPrice != p.price.toString() ||
        currentCost != p.cost.toString() ||
        stockCtrl.text.trim() != p.stock.toString() ||
        qrCodeCtrl.text.trim() != p.qrCode ||
        ((selectedUnit == "pack" || selectedUnit == "roll") &&
            packCtrl.text.trim() != p.packSize.toString()) ||
        _meterPriceValue != _originalMeterPrice ||
        selectedUnit != p.unit ||
        selectedCategoryId != p.category.id ||
        selectedFirmaId != p.firma?.id ||
        _wholesaleValue != _originalWholesale ||
        _minStockValue != _originalMinStock ||
        pickedImage != null;

    if (isChanged != changed) setState(() => isChanged = changed);
  }

  static final _moneyFormatters = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    ThousandsSeparatorFormatter(),
  ];

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.product.imageCollection.models.isNotEmpty
        ? widget.product.imageCollection.models.first.file
        : null;

    return MultiBlocListener(
      listeners: [
        BlocListener<PostMediaBloc, PostMediaState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (media) => sendUpdate(imageIds: [media.id]),
              failure: (err) => _showError(err.message),
            );
          },
        ),
        BlocListener<UpdateProductBloc, UpdateProductState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (_) {
                context.read<AllProductBloc>().add(AllProductEvent(
                      search: "",
                      cursor: "",
                      pageSize: 10,
                      category: "",
                      firmaId: widget.firmaId,
                      lowStock: false,
                    ));
                context.read<CashProductBloc>().add(
                      CashProductStarted(
                        search: "",
                        cursor: "",
                        pageSize: "all",
                        category: "",
                      ),
                    );
                Navigator.pop(context);
                _showError(tr("product_updated"));
              },
              failure: (err) => _showError(err.message),
            );
          },
        ),
      ],
      child: BlocBuilder<UpdateProductBloc, UpdateProductState>(
        builder: (context, state) {
          return AppSidePanel(
            title: tr("edit_product"),
            icon: Icons.edit_note_rounded,
            iconColor: AppColors.info,
            subtitle: widget.product.title,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImagePicker(
                      file: pickedImage,
                      imageUrl: imageUrl,
                      size: 112,
                      onPicked: (file) {
                        setState(() {
                          pickedImage = file;
                          isChanged = true;
                        });
                      },
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        children: [
                          AppTextField(
                            label: tr("product_name"),
                            controller: titleCtrl,
                          ),
                          const AppFormGap(),
                          AppTextField(
                              label: tr("sku"), controller: qrCodeCtrl),
                        ],
                      ),
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
                        controller: costCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: _moneyFormatters,
                      ),
                      AppTextField(
                        label: tr("sale_price"),
                        controller: priceCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: _moneyFormatters,
                      ),
                    ]),
                    AppTextField(
                      label: tr("wholesale_price"),
                      helper: tr("wholesale_price_hint"),
                      controller: wholesaleCtrl,
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
                        controller: stockCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      AppDropdown<String>(
                        label: tr("unit"),
                        value: selectedUnit,
                        items: [
                          for (final u in productUnits)
                            DropdownMenuItem(
                              value: u,
                              child: Text(unitLabel(u)),
                            ),
                        ],
                        onChanged: (v) {
                          setState(() {
                            selectedUnit = v;
                            if (v != "pack" && v != "roll") packCtrl.clear();
                          });
                          checkChanges();
                        },
                      ),
                    ]),
                    if (selectedUnit == "pack" || selectedUnit == "roll")
                      AppTextField(
                        label: selectedUnit == "roll"
                            ? tr("meters_in_piece")
                            : "${tr("pack")} ${tr("stock")}",
                        controller: packCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    if (selectedUnit == "roll")
                      AppTextField(
                        label: tr("meter_price"),
                        helper: tr("meter_price_hint"),
                        controller: meterPriceCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    AppTextField(
                      label: tr("min_stock"),
                      helper: tr("min_stock_hint"),
                      controller: minStockCtrl,
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
            actions: [
              AppButton.secondary(
                label: tr("cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              AppButton(
                label: tr("save_changes"),
                loading: state is UpdateProductPrepare,
                onPressed: isChanged ? handleUpdateAction : null,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _categoryDropdown() {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        final categories = state.maybeWhen(
          success: (model) => model.collection.models,
          orElse: () => <CategoryModel>[],
        );
        final safeValue = categories.any((c) => c.id == selectedCategoryId)
            ? selectedCategoryId
            : null;
        return AppDropdown<int>(
          label: tr("category"),
          hint: tr("select_category"),
          value: safeValue,
          items: categories
              .map((c) => DropdownMenuItem(value: c.id, child: Text(c.title)))
              .toList(),
          onChanged: (id) {
            setState(() => selectedCategoryId = id);
            checkChanges();
          },
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
        final safeValue =
            firms.any((f) => f.id == selectedFirmaId) ? selectedFirmaId : null;
        return AppDropdown<int>(
          label: tr("company"),
          hint: tr("select"),
          value: safeValue,
          items: firms
              .map((f) => DropdownMenuItem(value: f.id, child: Text(f.title)))
              .toList(),
          onChanged: (id) {
            setState(() => selectedFirmaId = id);
            checkChanges();
          },
        );
      },
    );
  }

  void handleUpdateAction() {
    if (pickedImage != null) {
      context.read<PostMediaBloc>().add(PostMediaStarted(image: pickedImage!));
    } else {
      final existingIds =
          widget.product.imageCollection.models.map((e) => e.id).toList();
      sendUpdate(imageIds: existingIds);
    }
  }

  void sendUpdate({required List<int> imageIds}) {
    final p = widget.product;
    context.read<UpdateProductBloc>().add(
          UpdateProductEventStarted(
            id: p.id,
            title:
                p.title != titleCtrl.text.trim() ? titleCtrl.text.trim() : "",
            cost: p.cost != costCtrl.text.trim()
                ? int.parse(num.parse(costCtrl.text.trim().replaceAll(' ', ''))
                    .toStringAsFixed(0))
                : 0,
            price: p.price != priceCtrl.text.trim()
                ? int.parse(num.parse(priceCtrl.text.trim().replaceAll(' ', ''))
                    .toStringAsFixed(0))
                : 0,
            stock: p.stock.toString() != stockCtrl.text.trim()
                ? double.parse(num.parse(stockCtrl.text.trim()).toString())
                : 0,
            categoryId:
                p.category.id != selectedCategoryId ? selectedCategoryId! : 0,
            unit: p.unit != selectedUnit ? selectedUnit! : "",
            packSize: (selectedUnit == "pack" || selectedUnit == "roll") &&
                    p.packSize.toString() != packCtrl.text.trim()
                ? int.parse(packCtrl.text.trim())
                : 0,
            imagesIds: imageIds,
            qrCode: p.qrCode != qrCodeCtrl.text.trim()
                ? qrCodeCtrl.text.trim()
                : "",
            firmaId: p.firma?.id != selectedFirmaId ? selectedFirmaId! : 0,
            wholesalePrice: _wholesaleValue,
            minStock: _minStockValue,
            meterPrice: selectedUnit == "roll" ? _meterPriceValue : null,
          ),
        );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
