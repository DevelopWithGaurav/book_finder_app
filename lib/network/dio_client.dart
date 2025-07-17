import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_endpoint.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoint.baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      followRedirects: true,
      maxRedirects: 5,
      headers: {
        "User-Agent": "BookFinderApp/1.0 (developwithgaurav323@gmail.com)",
        "Accept": "application/json",
      },
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        } else {
          return true;
        }
      },
    ),
  );

  Future<Response?> getData({required String path, Map<String, Object> parameters = const {}}) async {
    try {
      final Response response = await _dio.get(path, queryParameters: parameters);

      if (kDebugMode) {
        log(jsonEncode(response.data), name: '${_dio.options.baseUrl}$path - ${response.statusCode}');
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString(), name: 'ERROR AT getData');
      }
      rethrow;
    }
  }

  Future<Response?> postData({required String path, dynamic body}) async {
    try {
      final Response response = await _dio.post(path, data: body);

      if (kDebugMode) {
        log(jsonEncode(response.data), name: '${_dio.options.baseUrl}$path - ${response.statusCode}');
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString(), name: 'ERROR AT postData');
      }
      rethrow;
    }
  }
}
