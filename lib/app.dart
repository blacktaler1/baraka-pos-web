import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'features/cash/data/source/local_source/sync_pending_transactions.dart';
import 'features/global/data/source/network_notifier.dart';
import 'shared/aplication/aplication.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _startMonitoring() async {
    final initial = await _checkRealInternet();
    _updateInternetStatus(initial);

    // listen to'g'ri StreamSubscription<ConnectivityResult> beradi
    _connectivitySub = _connectivity.onConnectivityChanged.listen((result) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
        final connected = await _checkRealInternet();
        _updateInternetStatus(connected);

        // online bo'lsa, pending transaction sync qilamiz
        if (connected) {
          await syncPendingTransactions();
        }
      });
    });
  }

  Future<bool> _checkRealInternet() => checkInternet();

  void _updateInternetStatus(bool connected) {
    if (hasInternet == connected) return;
    hasInternet = connected;

    networkNotifier.updateStatus(connected);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: AppThemeConfig().theme,
      builder: (context, child) {
        // Telefon sozlamasidagi juda katta shriftlar maketni buzmasligi uchun
        final mq = MediaQuery.of(context);
        return MediaQuery(
          data: mq.copyWith(
            textScaler: mq.textScaler.clamp(maxScaleFactor: 1.15),
          ),
          child: child!,
        );
      },
    );
  }
}

bool hasInternet = true;
