import 'package:dio/dio.dart';

class CartTokenInterceptor extends Interceptor {
  CartTokenInterceptor(this.getCartToken);

  final Future<String?> Function() getCartToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? cartToken = await getCartToken();
    if (cartToken != null && cartToken.isNotEmpty) {
      options.headers['Cart-Token'] = cartToken;
    }
    handler.next(options);
  }
}
