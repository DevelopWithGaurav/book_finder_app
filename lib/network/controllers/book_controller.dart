import 'package:dio/dio.dart';

import '../../constants.dart';
import '../api_endpoint.dart';
import '../dio_client.dart';

class BookController {
  Future<Response?> searchBooks({int page = 1, required String query}) async {
    final path = '${ApiEndpoint.search}?limit=${Constants.apiDataLimit}&page=$page&q=$query&title=$query';
    return await DioClient().getData(path: path);
  }

  Future<Response?> fetchBookDetails({required String lendingEditionS}) async {
    final path = '${ApiEndpoint.bookDetails}/$lendingEditionS';

    return await DioClient().getData(path: path);
  }
}
