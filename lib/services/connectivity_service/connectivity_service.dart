import 'dart:async';
import 'dart:io';

import 'i_connectivity_service.dart';

class ConnectivityService extends IConnectivityService {
  ConnectivityService() {
    _connectionSubscription = streamInternetConnection().listen((event) {
      connectionController.add(event);
    });
  }

  StreamSubscription? _connectionSubscription;
  bool hasConnection = false;

  @override
  Future<bool> checkInternetConnection() async {
    //bool previousConnection = hasConnection;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }
    // if (previousConnection != hasConnection) {
    //   connectionChangeController.add(hasConnection);
    // }
    return hasConnection;
  }

  Stream<bool> streamInternetConnection() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      final res = await checkInternetConnection();
      connectionController.add(res);
      yield res;
    }
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    connectionController.close();
  }

  StreamController<bool> get connectionController =>
      StreamController.broadcast();
  @override
  Stream<bool> get connectionStream => connectionController.stream.distinct();
}
