import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:baraka_pos/features/firma/data/data.dart';
import 'package:baraka_pos/features/firma/presentation/blocs/delete_firma_bloc.dart/delete_firma_bloc.dart';
import 'package:baraka_pos/features/global/global.dart';
import 'package:baraka_pos/features/home/home.dart';
import 'package:baraka_pos/features/settings/settings.dart';
import 'package:baraka_pos/features/store/data/data.dart';
import 'package:baraka_pos/features/store/presentation/blocs/blocs.dart';
import 'package:baraka_pos/features/workers/data/data.dart';
import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:baraka_pos/features/workers/presentation/blocs/blocs.dart';
import 'package:baraka_pos/shared/shared.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../features/auth/auth.dart';
import '../../../../features/cash/data/source/local_source/cart_local_source.dart';
import '../../../../features/cash/data/source/local_source/connectivity_service.dart';
import '../../../../features/expenses/expenses.dart';
import '../../../../features/firma/domain/repository/firma_repository.dart';
import '../../../../features/firma/presentation/blocs/create_firma_bloc/create_firma_bloc.dart';
import '../../../../features/firma/presentation/blocs/create_loan_bloc/create_loan_bloc.dart';
import '../../../../features/firma/presentation/blocs/get_by_id_firma_bloc/get_by_id_firma_bloc.dart';
import '../../../../features/firma/presentation/blocs/get_firma_bloc/get_firma_bloc.dart';
import '../../../../features/firma/presentation/blocs/loan_debt_bloc/loan_debt_bloc.dart';
import '../../../../features/firma/presentation/blocs/pay_debt_bloc/pay_debt_bloc.dart';
import '../../../../features/firma/presentation/blocs/update_frima_bloc/update_firma_bloc.dart';
import '../../../../features/inventory/inventory.dart';
import '../../../../features/media/media.dart';
import '../../../../features/shift/shift.dart';
import '../../../../features/store/domain/domain.dart';
import '../../../data/sources/local_sources.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton(talker);

  sl.registerLazySingleton<Dio>(
    () => DioClient(
      talker: sl(),
    ).createDioClient(),
  );
  sl.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );

// PENDING TRANSACTION LOCAL SOURCE
  sl.registerLazySingleton<CartLocalSource>(() => CartLocalSource());

  sl.registerLazySingleton<PendingTransactionLocalSource>(
    () => PendingTransactionLocalSource(sl()),
  );
  sl.registerLazySingleton(
    () => PrinterSettingsDao(PosLocalDatabase.instance),
  );

  //TODO: Sources
  sl.registerLazySingleton<AuthRemoteSource>(
    () => AuthRemoteSource(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<WorkersRemoteSource>(
    () => WorkersRemoteSource(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<PosLocalDatabase>(
    () => PosLocalDatabase.instance,
  );

  sl.registerLazySingleton<AuthLocalSource>(
    () => AuthLocalSource(
      sl(),
    ),
  );
  sl.registerLazySingleton<CashProductLocalSource>(
    () => CashProductLocalSource(
      sl(),
    ),
  );
  sl.registerLazySingleton<MediaRemoteSource>(
    () => MediaRemoteSource(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<FirmaRemoteSource>(
    () => FirmaRemoteSource(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<CashRemoteSource>(
    () => CashRemoteSource(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryLocalSource>(
    () => CategoryLocalSource(),
  );

  sl.registerLazySingleton<StoreRemouteSource>(
    () => StoreRemouteSource(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<GlobalRemoteSource>(
    () => GlobalRemoteSource(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<SettingsRemouteSource>(
    () => SettingsRemouteSource(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<DashboardRemoteSource>(
    () => DashboardRemoteSource(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<DebtorRemouteSource>(
    () => DebtorRemouteSource(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<ExpensesRemoteSource>(
    () => ExpensesRemoteSource(
      client: sl(),
    ),
  );

  //TODO: repositories

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: sl(),
      local: sl(),
    ),
  );
  sl.registerLazySingleton<WorkersRepository>(
    () => WorkersRepositoryImpl(
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<MediaRepository>(
    () => MediaRepositoryImpl(
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<FirmaRepository>(
    () => FirmaRepositoryImpl(
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<CashRepository>(
    () => CashRepositoryImpl(
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<StoreRepository>(
    () => StoreRepositoryImpl(
      remote: sl(),
    ),
  );

  sl.registerLazySingleton<GlobalRepository>(
    () => GlobalRepositoryImpl(
      remote: sl(),
      local: sl(),
    ),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<DebtorsRepository>(
    () => DebtorsRepositoryImpl(
      remote: sl(),
    ),
  );

  sl.registerLazySingleton<ExpensesRepository>(
    () => ExpensesRepositoryImpl(
      remote: sl(),
    ),
  );

  //TODO: Blocs

  sl.registerLazySingleton<LoginBloc>(
    () => LoginBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<RefreshBloc>(
    () => RefreshBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<GetWorkerListBloc>(
    () => GetWorkerListBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<CreateWorkerBloc>(
    () => CreateWorkerBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateUserBloc>(
    () => UpdateUserBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<PostMediaBloc>(
    () => PostMediaBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetFirmaBloc>(
    () => GetFirmaBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<CreateProductBloc>(
    () => CreateProductBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetCategoryBloc>(
    () => GetCategoryBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CreateFirmaBloc>(
    () => CreateFirmaBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateFirmaBloc>(
    () => UpdateFirmaBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetByIdFirmaBloc>(
    () => GetByIdFirmaBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<AllProductBloc>(
    () => AllProductBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CashProductBloc>(
    () => CashProductBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateProductBloc>(
    () => UpdateProductBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteWorkerBloc>(
    () => DeleteWorkerBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<LoanDebtBloc>(
    () => LoanDebtBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteProductBloc>(
    () => DeleteProductBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CreateLoanBloc>(
    () => CreateLoanBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CreateDeviceBloc>(
    () => CreateDeviceBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<LoanFirmaBloc>(
    () => LoanFirmaBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<ChangePassBloc>(
    () => ChangePassBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetDashboardBloc>(
    () => GetDashboardBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CreateTransactionBloc>(
    () => CreateTransactionBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<TransactionBloc>(
    () => TransactionBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<RefoundTransactionBloc>(
    () => RefoundTransactionBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetRefundBloc>(
    () => GetRefundBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<LowStockBloc>(
    () => LowStockBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<DebtorFirmaBloc>(
    () => DebtorFirmaBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateShopInfoBloc>(
    () => UpdateShopInfoBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<StockUpdateBloc>(
    () => StockUpdateBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<GetLastVersionBloc>(
    () => GetLastVersionBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<InventoryRemoteSource>(
    () => InventoryRemoteSource(client: sl()),
  );

  sl.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(remote: sl()),
  );

  sl.registerLazySingleton<GetReceiptsBloc>(
    () => GetReceiptsBloc(repository: sl()),
  );

  sl.registerLazySingleton<CreateReceiptBloc>(
    () => CreateReceiptBloc(repository: sl()),
  );

  sl.registerFactory<ScanInvoiceBloc>(
    () => ScanInvoiceBloc(repository: sl()),
  );

  sl.registerLazySingleton<GetWriteOffsBloc>(
    () => GetWriteOffsBloc(repository: sl()),
  );

  sl.registerLazySingleton<CreateWriteOffBloc>(
    () => CreateWriteOffBloc(repository: sl()),
  );

  sl.registerLazySingleton<GetInventoryCountsBloc>(
    () => GetInventoryCountsBloc(repository: sl()),
  );

  sl.registerLazySingleton<GetInventoryCountBloc>(
    () => GetInventoryCountBloc(repository: sl()),
  );

  sl.registerLazySingleton<CreateInventoryCountBloc>(
    () => CreateInventoryCountBloc(repository: sl()),
  );

  sl.registerLazySingleton<AddInventoryItemBloc>(
    () => AddInventoryItemBloc(repository: sl()),
  );

  sl.registerLazySingleton<RemoveInventoryItemBloc>(
    () => RemoveInventoryItemBloc(repository: sl()),
  );

  sl.registerLazySingleton<CompleteInventoryCountBloc>(
    () => CompleteInventoryCountBloc(repository: sl()),
  );

  sl.registerLazySingleton<CancelInventoryCountBloc>(
    () => CancelInventoryCountBloc(repository: sl()),
  );

  sl.registerLazySingleton<ShiftRemoteSource>(
    () => ShiftRemoteSource(client: sl()),
  );

  sl.registerLazySingleton<ShiftRepository>(
    () => ShiftRepositoryImpl(remote: sl()),
  );

  sl.registerLazySingleton<GetShiftsBloc>(
    () => GetShiftsBloc(repository: sl()),
  );

  sl.registerLazySingleton<CurrentShiftBloc>(
    () => CurrentShiftBloc(repository: sl()),
  );

  sl.registerLazySingleton<OpenShiftBloc>(
    () => OpenShiftBloc(repository: sl()),
  );

  sl.registerLazySingleton<CloseShiftBloc>(
    () => CloseShiftBloc(repository: sl()),
  );

  sl.registerLazySingleton<ExportProductsBloc>(
    () => ExportProductsBloc(repository: sl()),
  );

  sl.registerLazySingleton<ImportProductsBloc>(
    () => ImportProductsBloc(repository: sl()),
  );

  sl.registerLazySingleton<GeneratedCodeBloc>(
    () => GeneratedCodeBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CreateCategoryBloc>(
    () => CreateCategoryBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<DailyChecksBloc>(
    () => DailyChecksBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetCategoryPagBloc>(
    () => GetCategoryPagBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateCategoryBloc>(
    () => UpdateCategoryBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteFirmaBloc>(
    () => DeleteFirmaBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<DeleteCategoryBloc>(
    () => DeleteCategoryBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<GetDebtorsListBloc>(
    () => GetDebtorsListBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CreateCustomerBloc>(
    () => CreateCustomerBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetCustomerBloc>(
    () => GetCustomerBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<ByCustomerBloc>(
    () => ByCustomerBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<PayCustomerDebtsBloc>(
    () => PayCustomerDebtsBloc(repository: sl()),
  );

  sl.registerLazySingleton<ExportDebtorsBloc>(
    () => ExportDebtorsBloc(repository: sl()),
  );

  sl.registerLazySingleton<PayDebtBloc>(
    () => PayDebtBloc(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<CartBloc>(
    () => CartBloc(),
  );

  sl.registerLazySingleton<GlobalProductSearchBloc>(
    () => GlobalProductSearchBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetExpensesBloc>(
    () => GetExpensesBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<CreateExpenseBloc>(
    () => CreateExpenseBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateExpenseBloc>(
    () => UpdateExpenseBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteExpenseBloc>(
    () => DeleteExpenseBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<ByCustomerHistoryBloc>(
    () => ByCustomerHistoryBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetTurnoverBloc>(
    () => GetTurnoverBloc(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetProfitBloc>(
    () => GetProfitBloc(
      repository: sl(),
    ),
  );
}
