import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.getAuthorizationHeader);

  final Future<String?> Function() getAuthorizationHeader;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? authHeader = await getAuthorizationHeader();
    if (authHeader != null && authHeader.isNotEmpty) {
      options.headers['Authorization'] = authHeader;
    }
    handler.next(options);
  }
}
