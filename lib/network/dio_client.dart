import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_endpoint.dart';

/// A reusable HTTP client wrapper around Dio for making GET and POST requests.
/// Handles base configuration, logging, and error management centrally.
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

  /// Generic GET request method.
  ///
  /// [path]: Relative API endpoint path.
  /// [parameters]: Optional query parameters.
  /// Logs the response in debug mode and returns the Response object.
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

  /// Generic POST request method.
  ///
  /// [path]: Relative API endpoint path.
  /// [body]: Request body (can be JSON or Map).
  /// Logs the response in debug mode and returns the Response object.
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
