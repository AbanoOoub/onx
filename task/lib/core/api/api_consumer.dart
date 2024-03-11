abstract class ApiConsumer {
  Future<dynamic> get(String path,
      {String? token, Map<String, dynamic>? queryParameters});

  Future<dynamic> post(String path,
      {String? token,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters});

  Future<dynamic> put(String path,
      {String? token,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters});
}
