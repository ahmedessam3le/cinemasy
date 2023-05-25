import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../const/app_values.dart';
import '../utils/app_utils.dart';

class DioManager {
  Dio? _dioInstance;

  Dio? get dio {
    _dioInstance ??= initDio();
    return _dioInstance;
  }

  Dio initDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppValues.baseUrl,
        headers: <String, String>{},
        sendTimeout: 120 * 1000,
        connectTimeout: 120 * 1000,
        receiveTimeout: 120 * 1000,
      ),
    );
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
    }
    return dio;
  }

  void update() => _dioInstance = initDio();

  Future<Response> get(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    return await dio!
        .get(
      path,
      queryParameters: parameters,
      options: Options(headers: headers),
    )
        .then((response) {
      return response;
    }).catchError((dynamic error) async {
      AppUtils.errorToast(
        code: error.response?.data?['status_code']?.toString() ?? '',
        message:
            '${error.response?.data?['status_message']?.toString() ?? ''} error',
      );
    });
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    return await dio!
        .post(
      path,
      data: body,
      options: Options(headers: headers),
    )
        .then((response) {
      return response;
    }).catchError((dynamic error) {
      AppUtils.errorToast(
        code: error.response?.data?['status_code']?.toString() ?? '',
        message:
            '${error.response?.data?['status_message']?.toString() ?? ''} error',
      );
    });
  }

  Future<Response> put(
    String path, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    return await dio!
        .put(
      path,
      data: body,
      options: Options(headers: headers),
    )
        .then((response) {
      return response;
    }).catchError((dynamic error) {
      AppUtils.errorToast(
        code: error.response?.data?['status_code']?.toString() ?? '',
        message:
            '${error.response?.data?['status_message']?.toString() ?? ''} error',
      );
    });
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    return await dio!
        .delete(
      path,
      data: body,
      options: Options(headers: headers),
    )
        .then((response) {
      return response;
    }).catchError((dynamic error) {
      AppUtils.errorToast(
        code: error.response?.data?['status_code']?.toString() ?? '',
        message:
            '${error.response?.data?['status_message']?.toString() ?? ''} error',
      );
    });
  }
}
