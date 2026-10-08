import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../global/presentation/blocs/get_category_bloc/get_category_bloc.dart';
import '../blocs/cash_product_bloc/cash_product_bloc.dart';
import '../widgets/cash_category_section.dart';
import '../widgets/cash_products_section.dart';
import '../widgets/cash_register_navbar.dart';
import 'package:baraka_pos/shared/design/design.dart';

class CashScreen extends StatefulWidget {
  const CashScreen({super.key});

  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {
  final ScrollController _categoryController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  String selectedCategory = '';
  bool isAtStart = true;
  bool isAtEnd = false;
  Timer? _debounce;
  final FocusNode _scannerFocusNode = FocusNode();
  String _barcodeBuffer = "";
  List<String?> cursors = [null];

  @override
  void initState() {
    super.initState();

    context.read<GetCategoryBloc>().add(GetCategoryStarted(
          cursor: "",
          pageSize: "all",
        ));
    loadProductData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollButtons();

      _categoryController.addListener(_updateScrollButtons);
    });
  }

  @override
  void dispose() {
    _categoryController.dispose();

    searchController.dispose();

    _scannerFocusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final shell = StatefulNavigationShell.of(context);

    if (shell.currentIndex == 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scannerFocusNode.requestFocus();
      });
    }
  }

  void _updateScrollButtons() {
    if (!_categoryController.hasClients) {
      return;
    }
    setState(() {
      isAtStart = _categoryController.offset <= 0;
      isAtEnd = _categoryController.offset >=
          _categoryController.position.maxScrollExtent;
    });
  }

  void _scrollLeft() {
    _categoryController.animateTo(
      (_categoryController.offset - 200)
          .clamp(0, _categoryController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    _categoryController.animateTo(
      (_categoryController.offset + 200)
          .clamp(0, _categoryController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void onCategorySelect(String title) {
    setState(() {
      selectedCategory = title;
    });
    loadProductData();
  }

  void _handleBarcodeScan(BuildContext context, KeyEvent event) {
    if (searchFocusNode.hasFocus) return;
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (_barcodeBuffer.isNotEmpty) {
          _findLocalProduct(context, _barcodeBuffer);

          _barcodeBuffer = "";
        }
      } else {
        final char = event.character;

        if (char != null) {
          _barcodeBuffer += char;
        }
      }
    }
  }

  void _findLocalProduct(BuildContext context, String barcode) {
    final cleanBarcode = barcode.trim();

    final state = context.read<CashProductBloc>().state;

    state.maybeWhen(
      success: (model) {
        final product = model.data.models.firstWhereOrNull(
          (e) => e.qrcode.toString().trim() == cleanBarcode,
        );

        if (product != null) {
          context.push("/cash_register", extra: product);
          searchController.clear();
          SystemSound.play(SystemSoundType.click);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${product.title} ${tr(("add_cassa"))}"),
              backgroundColor: AppColors.success,
              duration: const Duration(milliseconds: 500),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${tr("cassa_not_found")} $cleanBarcode"),
              backgroundColor: AppColors.warning,
            ),
          );
        }
      },
      orElse: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr("cassa_loading"))),
        );
      },
    );
  }

  void loadProductData() {
    context.read<CashProductBloc>().add(
          CashProductStarted(
            search: searchController.text,
            cursor: "",
            pageSize: "all",
            category: selectedCategory,
          ),
        );
  }

  void onSearchChange(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      loadProductData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (innerContext) {
      return KeyboardListener(
          focusNode: _scannerFocusNode,
          autofocus: true,
          onKeyEvent: (event) => _handleBarcodeScan(context, event),
          child: GestureDetector(
            onTap: () => _scannerFocusNode.requestFocus(),
            child: AppPage(
              toolbar: const CashRegisterNavbar(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CashCategorySection(
                    categoryController: _categoryController,
                    selectedCategory: selectedCategory,
                    isAtStart: isAtStart,
                    isAtEnd: isAtEnd,
                    onCategorySelect: onCategorySelect,
                    scrollLeft: _scrollLeft,
                    scrollRight: _scrollRight,
                  ),
                  SizedBox(
                      height: context.isMobile ? AppSpacing.sm : AppSpacing.xl),
                  Expanded(
                    child: CashProductsSection(
                      searchController: searchController,
                      searchFocusNode: searchFocusNode,
                      scannerFocusNode: _scannerFocusNode,
                      onSearchChange: onSearchChange,
                      onScan: (code) => _findLocalProduct(innerContext, code),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
