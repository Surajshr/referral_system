import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityChecker {
  Future<bool> isInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      try {
        final List<InternetAddress> result = await InternetAddress.lookup(
          'google.com',
        );
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  Future<bool> isInternetConnected() async {
    final isConnected = await isInternet();
    return isConnected;
  }
}

enum ConnectivityStatus { connecting, connected, disConnected }
