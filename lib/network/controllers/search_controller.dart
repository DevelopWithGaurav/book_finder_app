import 'package:dio/dio.dart';

import '../../constants.dart';
import '../api_endpoint.dart';
import '../dio_client.dart';

class SearchBookController {
  Future<Response?> searchBooks({int page = 1, required String query}) async {
    final path = '${ApiEndpoint.search}?limit=${Constants.apiDataLimit}&page=$page&q=$query&title=$query';
    return await DioClient().getData(path: path);
  }
}
