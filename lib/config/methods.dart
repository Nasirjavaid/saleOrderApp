import 'package:connectivity/connectivity.dart';

class NetworkConnectivity {
  static const String NETWORK_NOT_AVAILABLE =
      "Internet connection is not available";

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}