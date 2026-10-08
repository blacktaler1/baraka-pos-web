import 'package:baraka_pos/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/aplication/configs/app_router_config.dart';
import '../../../../shared/presentation/widgets/receipt_share.dart';
import '../blocs/cash_product_bloc/cash_product_bloc.dart';
import '../blocs/create_transaction_bloc/create_transaction_bloc.dart';
import 'package:baraka_pos/shared/design/design.dart';

class CashRegisterPay extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback removeFromOrder;
  final String grandTotal;

  const CashRegisterPay(
      {super.key,
      required this.onPressed,
      required this.grandTotal,
      required this.removeFromOrder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
          onPressed: onPressed,
          child: BlocConsumer<CreateTransactionBloc, CreateTransactionState>(
            listener: (context, state) {
              state.whenOrNull(success: (model) async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("payment_success".tr()),
                  ),
                );
                if (hasInternet) {
                  context.read<CashProductBloc>().add(
                        CashProductStarted(
                          search: "",
                          cursor: "",
                          pageSize: "all",
                          category: "",
                        ),
                      );
                }

                // Oxirgi buyurtma yopilsa kassa sahifasi ham yopiladi,
                // shuning uchun chek oynasini root navigator orqali ochamiz
                final rootContext = rootNavigatorKey.currentContext;
                removeFromOrder();
                // Printer o'rniga: chekni PDF qilib mijozga yuborish
                if (rootContext != null && rootContext.mounted) {
                  showReceiptShareSheet(
                    rootContext,
                    model,
                    title: "payment_success".tr(),
                  );
                }
              }, failure: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.message)),
                );
              });
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => Text(
                  "${"pay".tr()} : $grandTotal",
                  style: AppText.h3.copyWith(color: Colors.white),
                ),
                inPrepare: () => const SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.5, color: Colors.white),
                ),
                success: (model) => Text(
                  "${"pay".tr()} : $grandTotal",
                  style: AppText.h3.copyWith(color: Colors.white),
                ),
                failure: (error) => Text(
                  "error: $error",
                  style: AppText.h3.copyWith(color: Colors.white),
                ),
              );
            },
          )),
    );
  }
}
