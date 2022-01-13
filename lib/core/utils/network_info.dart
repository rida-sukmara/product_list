// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:product_list/core/utils/i_network_info.dart';

class NetworkInfo extends INetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfo({required this.connectionChecker});

  @override
  Future<bool> isConnected() async {
    return await connectionChecker.checkConnectivity() !=
        ConnectivityResult.none;
  }
}
