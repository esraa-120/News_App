import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService {

  ConnectivityService._();
  static final Connectivity _connectivity = Connectivity();

  static bool _isConnected = true;

  static bool get isConnected => _isConnected;

  static Future<void> init() async {
    _isConnected = _hasConnection(await _connectivity.checkConnectivity());
    _connectivity.onConnectivityChanged.listen((results) {
      _isConnected = _hasConnection(results);
    });
  }

  static bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}