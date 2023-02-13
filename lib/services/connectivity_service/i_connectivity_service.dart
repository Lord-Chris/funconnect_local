abstract class IConnectivityService {
  Future<bool> checkInternetConnection();
  void dispose();
  Stream<bool> get connectionStream;
}
