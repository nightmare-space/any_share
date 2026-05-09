import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioService {
  DioService._internal({BaseOptions? options}) {
    dio = Dio(options ?? _defaultOptions());
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }
  }
  static final DioService instance = DioService._internal();
  late final Dio dio;

  static BaseOptions _defaultOptions() => BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
  );

  // TODO: Check this if works
  void updateOptions(BaseOptions options) {
    dio.options = dio.options.copyWith(
      baseUrl: options.baseUrl,
      headers: options.headers,
      connectTimeout: options.connectTimeout,
      receiveTimeout: options.receiveTimeout,
      sendTimeout: options.sendTimeout,
    );
  }
}

// ignore: non_constant_identifier_names
final DioClient = DioService.instance.dio;
