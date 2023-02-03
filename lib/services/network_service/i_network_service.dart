import 'package:funconnect/core/models/_models.dart';

abstract class INetworkService {
  Future<ApiResponse<Map<String, dynamic>>> get(
    String url, {
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> put(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> delete(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });
}
