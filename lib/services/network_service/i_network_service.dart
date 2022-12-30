import 'package:funconnect/models/api_response.dart';

abstract class INetworkService {
  Future<ApiResponse<Map<String, dynamic>>> get(
    String url, {
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> post(
    String url, {
    Map body,
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> put(
    String url, {
    Map body,
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> delete(
    String url, {
    Map body,
    Map<String, String>? headers,
  });
}
