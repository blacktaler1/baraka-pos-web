import 'package:baraka_pos/app.dart';
import 'package:baraka_pos/features/cash/presentation/presentation.dart';
import 'package:baraka_pos/features/debtors/presentation/screens/screens.dart';
import 'package:baraka_pos/features/firma/presentation/screens/firma_screen.dart';
import 'package:baraka_pos/features/global/global.dart';
import 'package:baraka_pos/features/settings/presentation/screens/settings_screen.dart';
import 'package:baraka_pos/features/store/presentation/screens/screens.dart';
import 'package:baraka_pos/features/workers/presentation/presentation.dart';
import 'package:baraka_pos/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../features/auth/auth.dart';
import '../../../features/cash/data/source/local_source/cart_local_source.dart';
import '../../../features/cash/domain/model/cash_product_model.dart';
import '../../../features/cash/presentation/screens/transaction_screen.dart';
import '../../../features/expenses/presentation/screens/expenses_screen.dart';
import '../../../features/firma/presentation/screens/firma_information_screen.dart';
import '../../../features/home/presentation/presentation.dart';
import '../../../features/inventory/inventory.dart';
import '../../../features/shift/shift.dart';

final routeObserver = TalkerRouteObserver(talker);
final rootNavigatorKey = GlobalKey<NavigatorState>();

class RoleGuard extends GoRoute {
  RoleGuard({
    required super.path,
    required super.name,
    required String requiredRole,
    bool isPublic = false,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) : super(
          redirect: (context, state) {
            if (globalUser == null) return "/auth";
            return null;
          },
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: ListenableBuilder(
                listenable: networkNotifier,
                builder: (context, child) {
                  if (!requiredRole.contains(globalUser!.role) &&
                      globalUser!.role != "admin") {
                    return const NotAllow();
                  }

                  if (!isPublic && hasInternet == false) {
                    return const NoInternet();
                  }

                  return builder(context, state);
                },
              ),
            );
          },
        );
}

final GoRouter appRouter = GoRouter(
  initialLocation: "/splash",
  refreshListenable: networkNotifier,
  navigatorKey: rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShellScaffold(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          initialLocation: '/home',
          routes: [
            RoleGuard(
              name: 'home',
              path: '/home',
              requiredRole: "admin",
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/store',
          routes: [
            RoleGuard(
              name: 'store',
              path: '/store',
              requiredRole: "manager",
              builder: (context, state) => StoreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/cash',
          routes: [
            RoleGuard(
              name: 'cash',
              path: '/cash',
              requiredRole: "cashier,manager",
              isPublic: true,
              builder: (context, state) => CashScreen(),
            ),
            GoRoute(
              path: "/transaction",
              name: "transaction",
              builder: (context, state) => const TransactionScreen(),
            ),
            GoRoute(
              path: "/daily_checks",
              name: "daily_checks",
              builder: (context, state) => const DailyChecksScreen(),
            ),
            GoRoute(
              path: "/refund",
              name: "refund",
              builder: (context, state) => const RefundScreen(),
            ),
            GoRoute(
              path: "/shifts",
              name: "shifts",
              builder: (context, state) => const ShiftsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/workers',
          routes: [
            RoleGuard(
              name: 'workers',
              path: '/workers',
              requiredRole: "admin",
              builder: (context, state) => WorkersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/firma',
          routes: [
            RoleGuard(
              name: 'firma',
              path: '/firma',
              requiredRole: "manager",
              builder: (context, state) => FirmaScreen(),
            ),
            RoleGuard(
              name: 'firma-Information',
              path: '/firma-Information',
              requiredRole: "manager",
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>;
                final firmaId = extra['firmaId'] as int;
                final remainder = extra['remainder'] as num;

                return FirmaInformationScreen(
                  firmaId: firmaId,
                  remainder: remainder,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/category',
          routes: [
            RoleGuard(
              name: 'category',
              path: '/category',
              requiredRole: "manager",
              builder: (context, state) => CategoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/debtors',
          routes: [
            RoleGuard(
              name: 'debtors',
              path: '/debtors',
              requiredRole: "cashier,manager",
              builder: (context, state) => DebtorsListScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/expenses',
          routes: [
            RoleGuard(
              name: 'expenses',
              path: '/expenses',
              requiredRole: "cashier,manager",
              builder: (context, state) => ExpensesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/stock-operations',
          routes: [
            RoleGuard(
              name: 'stock-operations',
              path: '/stock-operations',
              requiredRole: "manager",
              builder: (context, state) => const StockOperationsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/settings',
          routes: [
            GoRoute(
              name: 'settings',
              path: '/settings',
              pageBuilder: (context, state) => CupertinoPage(
                child: SettingsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/not_allow",
              builder: (context, state) => const NotAllow(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/splash",
      name: "splash",
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: "/auth",
      name: "auth",
      builder: (context, state) => AuthScreen(),
    ),
    GoRoute(
      path: '/forbidden',
      name: 'forbidden',
      builder: (context, state) => const ForbiddenScreen(),
    ),
    GoRoute(
      path: "/no_internet",
      name: "no_internet",
      builder: (context, state) => const NoInternetScreen(),
    ),
    GoRoute(
      path: "/cash_register",
      name: "cash_register",
      builder: (context, state) {
        final product = state.extra as CashProductModel?;

        return BlocProvider(
          create: (_) =>
              CartBloc(storage: sl<CartLocalSource>())..add(InitializeCart()),
          child: CashRegisterScreen(
            initialProduct: product,
          ),
        );
      },
    ),
  ],
);
