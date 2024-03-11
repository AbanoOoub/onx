import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST METHOD ${options.method}');
    debugPrint('REQUEST PATH ${options.baseUrl}${options.path}');
    debugPrint('REQUEST DATA ${options.data}');
    debugPrint('REQUEST QUERY-PARAMETERS ${options.queryParameters}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE PATH ${response.realUri}');
    debugPrint('RESPONSE BODY: ${response.data}', wrapWidth: 2000);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    debugPrint('ERROR Type: ${err.type}', wrapWidth: 2000);
    debugPrint('ERROR message: ${err.message}', wrapWidth: 2000);

    super.onError(err, handler);
  }
}
