import 'package:dio/dio.dart';

import '../../constants.dart';
import '../api_endpoint.dart';
import '../dio_client.dart';

/// A controller class responsible for making API calls
/// related to book search and book details.
class BookController {
  /// Searches for books using the OpenLibrary API.
  ///
  /// [query]: The search term entered by the user.
  /// [page]: The page number for paginated results (default is 1).
  ///
  /// Constructs the URL with parameters:
  /// - `limit`: max results per page (from Constants)
  /// - `q` and `title`: set to the same query string
  ///
  /// Returns a [Response] or null if the request fails.
  Future<Response?> searchBooks({int page = 1, required String query}) async {
    final path = '${ApiEndpoint.search}?limit=${Constants.apiDataLimit}&page=$page&q=$query&title=$query';
    return await DioClient().getData(path: path);
  }

  /// Fetches detailed information of a book using its `lendingEditionS` key.
  ///
  /// Constructs the endpoint URL dynamically and uses Dio to fetch data.
  ///
  /// Returns a [Response] or null on failure.
  Future<Response?> fetchBookDetails({required String lendingEditionS}) async {
    final path = '${ApiEndpoint.bookDetails}/$lendingEditionS';

    return await DioClient().getData(path: path);
  }
}
