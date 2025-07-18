/// A central place to define and manage API endpoint paths.
///
/// Helps in avoiding hardcoded strings throughout the app and ensures
/// consistent usage of base and relative URLs.
class ApiEndpoint {
  static const String baseUrl = 'https://openlibrary.org/';

  static const String search = 'search.json';
  static const String bookDetails = 'books';
}
