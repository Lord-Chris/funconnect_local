import 'dart:io';

import 'package:dio/dio.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:logger/logger.dart';

import 'i_network_service.dart';
import 'network_logger.dart';

class NetworkService extends INetworkService {
  Dio _dio = Dio();
  final _logger = Logger();

  final _headers = {'Accept': 'application/json'};

  NetworkService() {
    _dio = Dio();
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.options.sendTimeout = const Duration(seconds: 60);
    _dio.interceptors.add(NetworkLoggerInterceptor());
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> delete(String url,
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
      throw Failure(res.statusMessage!);
    } on DioError catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> get(String url,
      {Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.get(
        url,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw Failure(res.statusMessage!);
    } on DioError catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> put(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.put(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw Failure(res.statusMessage!);
    } on DioError catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> post(String url,
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
      throw Failure(res.statusMessage!);
    } on DioError catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> postFile(
      String url, String key, File file,
      {Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
          {key: await MultipartFile.fromFile(file.path, filename: fileName)});

      final res = await _dio.post(
        url,
        data: formData,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw Failure(res.statusMessage!);
    } on DioError catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(e.toString());
    }
  }

  Failure convertException(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return const Failure("Connection Timed Out");
      case DioErrorType.sendTimeout:
        return const Failure("Connection Timed Out");
      case DioErrorType.receiveTimeout:
        return const Failure("Connection Timed Out");
      case DioErrorType.badResponse:
        return Failure(
            e.response?.data['message'] ?? e.response?.data['errors']);
      case DioErrorType.cancel:
        return Failure(
            e.response?.data['message'] ?? e.response?.data['errors']);
      case DioErrorType.unknown:
        return const Failure("No Internet Connection");
      default:
        return const Failure("No Internet Connection");
    }
  }
}
