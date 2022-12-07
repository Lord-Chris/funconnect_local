import 'package:funconnect/models/api_response.dart';

abstract class INetworkService {
  Future<ApiResponse?> get(
    String url, {
    Map body,
    Map<String, String>? headers,
  });

  Future<ApiResponse?> post(
    String url, {
    Map body,
    Map<String, String>? headers,
  });

  Future<ApiResponse?> patch(
    String url, {
    Map body,
    Map<String, String>? headers,
  });

  Future<ApiResponse?> delete(
    String url, {
    Map body,
    Map<String, String>? headers,
  });
}
