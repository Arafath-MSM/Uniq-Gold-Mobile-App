import 'package:dio/dio.dart';

import '../config/env.dart';
import '../storage/local_storage_service.dart';
import '../storage/secure_storage_service.dart';
import 'auth_interceptor.dart';
import 'cart_token_interceptor.dart';

class ApiClient {
  ApiClient({
    required SecureStorageService secureStorageService,
    required LocalStorageService localStorageService,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: Env.baseUrl,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(secureStorageService.readAuthorizationHeader),
      CartTokenInterceptor(localStorageService.readCartToken),
    ]);
  }

  final Dio dio;
}
