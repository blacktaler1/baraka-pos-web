import 'package:baraka_pos/app.dart';
import 'package:baraka_pos/features/home/presentation/blocs/blocs.dart';
import 'package:baraka_pos/features/settings/presentation/blocs/blocs.dart';
import 'package:baraka_pos/features/store/presentation/blocs/blocs.dart';
import 'package:baraka_pos/features/workers/presentation/blocs/blocs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

import 'features/auth/auth.dart';
import 'features/cash/cash.dart';
import 'features/debtors/debtors.dart';
import 'features/expenses/expenses.dart';
import 'features/firma/firma.dart';
import 'features/global/global.dart';
import 'features/inventory/inventory.dart';
import 'features/media/media.dart';
import 'features/shift/shift.dart';
import 'shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: TalkerBlocLoggerSettings(
      printCreations: true,
      printClosings: true,
    ),
  );

  await EasyLocalization.ensureInitialized();

  await initDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('ru'),
        Locale('uz'),
      ],
      path: "assets/langs",
      fallbackLocale: Locale('uz'),
      startLocale: Locale('uz'),
      saveLocale: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<LoginBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetWorkerListBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateWorkerBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<UpdateUserBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<RefreshBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<PostMediaBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetFirmaBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateProductBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetCategoryBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateFirmaBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<UpdateFirmaBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetByIdFirmaBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<AllProductBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CashProductBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<UpdateProductBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<DeleteWorkerBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<DeleteProductBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<LoanDebtBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateLoanBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateDeviceBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<LoanFirmaBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<ChangePassBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetDashboardBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateTransactionBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<TransactionBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<RefoundTransactionBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<LowStockBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<DebtorFirmaBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetRefundBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<UpdateShopInfoBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<StockUpdateBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetLastVersionBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GeneratedCodeBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<ExportProductsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetReceiptsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateReceiptBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<ScanInvoiceBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetWriteOffsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateWriteOffBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetInventoryCountsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetInventoryCountBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateInventoryCountBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<AddInventoryItemBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<RemoveInventoryItemBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CompleteInventoryCountBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CancelInventoryCountBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetShiftsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CurrentShiftBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<OpenShiftBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CloseShiftBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<ImportProductsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateCategoryBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<DailyChecksBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetCategoryPagBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<UpdateCategoryBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<DeleteFirmaBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<DeleteCategoryBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetDebtorsListBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateCustomerBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetCustomerBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<ByCustomerBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<PayDebtBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<PayCustomerDebtsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<ExportDebtorsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CartBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetExpensesBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<CreateExpenseBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<UpdateExpenseBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<DeleteExpenseBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GlobalProductSearchBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<ByCustomerHistoryBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetTurnoverBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetProfitBloc>(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}
