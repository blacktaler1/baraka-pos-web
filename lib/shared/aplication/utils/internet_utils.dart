import 'package:connectivity_plus/connectivity_plus.dart';

/// Webda socket/DNS tekshiruvi yo'q — brauzer bergan tarmoq holatiga tayanamiz
Future<bool> checkInternet() async {
  try {
    final result = await Connectivity().checkConnectivity();
    return result.any((r) => r != ConnectivityResult.none);
  } catch (_) {
    return true;
  }
}
