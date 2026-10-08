import 'package:flutter/cupertino.dart';

class NetworkNotifier extends ChangeNotifier {
  bool _hasInternet = true;
  bool get hasInternet => _hasInternet;

  void updateStatus(bool status) {
    if (_hasInternet != status) {
      _hasInternet = status;
      notifyListeners();
    }
  }
}

final networkNotifier = NetworkNotifier();
