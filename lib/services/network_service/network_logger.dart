import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class NetworkLoggerInterceptor implements Interceptor {
  final _logger = Logger();
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '---ENDPOINT: ${err.requestOptions.uri}\n'
      '---STATUSCODE: ${err.error}\n'
      '---MESSAGE: ${err.response?.data ?? err.message}',
    );
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final data = options.data is FormData
        ? (options.data as FormData).files + (options.data as FormData).files
        : options.data ?? options.queryParameters;
    _logger.d(
      '>>>METHOD: ${options.method}\n'
      '>>>ENDPOINT: ${options.uri}\n'
      // log('HEADERS: ' + options.headers.toString());
      '>>>DATA: $data',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      '<<<ENDPOINT: ${response.requestOptions.uri}'
      '<<<STATUSCODE: ${response.statusCode}'
      '<<<DATA: ${response.data}',
    );
    handler.next(response);
  }
}
