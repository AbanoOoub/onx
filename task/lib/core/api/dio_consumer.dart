import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:task/injection_container.dart' as di;
import 'package:task/core/api/status_code.dart';
import '../error/exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {

    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..contentType = Headers.jsonContentType
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppInterceptors>());
    // if (kDebugMode) {
    //   client.interceptors.add(di.sl<LogInterceptor>());
    // }
  }

  @override
  Future get(String path,
      {String? token, Map<String, dynamic>? queryParameters}) async {
    try {
      token != null
          ? client.options.headers = {
              'Authorization': 'Bearer $token',
            }
          : '';
      final response = await client.get(path,
          options: Options(
              headers: token != null
                  ? {
                      'Authorization': 'Bearer $token',
                    }
                  : {}),
          queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {String? token,
      Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          options: Options(
              headers: token != null
                  ? {
                      'Authorization': 'Bearer $token',
                    }
                  : {}),
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {String? token,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.put(path,
          options: Options(
              headers: token != null
                  ? {
                      'Authorization': 'Bearer $token',
                    }
                  : {}),
          queryParameters: queryParameters,
          data: body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        throw const BadCertificateException();
      case DioExceptionType.badResponse:
        throw const BadResponseException();
      case DioExceptionType.connectionError:
        throw const ConnectionErrorException();
      case DioExceptionType.unknown:
        switch (exception.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
            throw const UnauthorizedException();
          case StatusCode.forbidden:
            throw const ForbiddenException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
    }
  }
}
