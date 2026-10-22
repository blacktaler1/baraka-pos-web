import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../store/presentation/blocs/all_product_bloc/all_product_bloc.dart';
import '../blocs/cash_product_bloc/cash_product_bloc.dart';

/// Vozvrat yoki sotuvni tahrirlash qoldiqni o'zgartiradi — ombor va kassa
/// ro'yxatlari serverdan qayta olinadi, aks holda eski qoldiq ko'rinib qoladi
void refreshStockLists(BuildContext context) {
  context.read<CashProductBloc>().add(
        CashProductStarted(
          search: "",
          cursor: "",
          pageSize: "all",
          category: "",
        ),
      );
  context.read<AllProductBloc>().add(AllProductEvent(
        search: '',
        cursor: '',
        pageSize: 0,
        firmaId: 0,
        category: '',
        lowStock: false,
      ));
}
