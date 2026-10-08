import '../../../../../shared/aplication/utils/internet_utils.dart';

abstract class ConnectivityService {
  Future<bool> hasInternet();
}

class ConnectivityServiceImpl implements ConnectivityService {
  @override
  Future<bool> hasInternet() => checkInternet();
}
