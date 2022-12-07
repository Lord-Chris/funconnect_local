import 'package:dio/dio.dart';
import 'package:funconnect/models/failure.dart';
import 'package:logger/logger.dart';

import '../../models/api_response.dart';
import 'i_network_service.dart';
import 'network_logger.dart';

class NetworkService extends INetworkService {
  Dio _dio = Dio();
  final _logger = Logger();

  final _headers = {'Accept': 'application/json'};

  NetworkService() {
    _dio = Dio();
    _dio.options.baseUrl = "ApiStrings.base_url";
    _dio.options.receiveTimeout = 60 * 1000;
    _dio.options.sendTimeout = 60 * 1000;
    _dio.interceptors.add(NetworkLoggerInterceptor());
  }

  @override
  Future<ApiResponse?> delete(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.delete(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw res.statusMessage!;
    } on DioError catch (e) {
      _logger.e(e.toString());
      convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
    return null;
  }

  @override
  Future<ApiResponse?> get(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.get(
        url,
        queryParameters: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw res.statusMessage!;
    } on DioError catch (e) {
      _logger.e(e.toString());
      convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
    return null;
  }

  @override
  Future<ApiResponse?> patch(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.patch(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw res.statusMessage!;
    } on DioError catch (e) {
      _logger.e(e.toString());
      convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
    return null;
  }

  @override
  Future<ApiResponse?> post(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.post(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw res.statusMessage!;
    } on DioError catch (e) {
      _logger.e(e.toString());
      convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
    return null;
  }

  Failure convertException(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        throw const Failure("Connection Timed Out");
      case DioErrorType.sendTimeout:
        throw const Failure("Connection Timed Out");
      case DioErrorType.receiveTimeout:
        throw const Failure("Connection Timed Out");
      case DioErrorType.response:
        throw Failure(e.response?.data['message'] ?? e.response?.data['error']);
      case DioErrorType.cancel:
        throw Failure(e.response?.data['message'] ?? e.response?.data['error']);
      case DioErrorType.other:
        throw const Failure("No Internet Connection");
    }
  }
}
