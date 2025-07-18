/// A utility class to generate OpenLibrary cover image URLs
/// based on the book's `coverKey` and required size.
class BookCoverHelper {
  /// Returns the full URL of a book cover image.
  ///
  /// [isThumbnail]: If true, returns a small-sized image (S), else medium (M).
  /// [coverKey]: Unique identifier for the book's cover.
  ///
  /// Example output:
  /// - Small: https://covers.openlibrary.org/b/OLID/OL12345S.jpg
  /// - Medium: https://covers.openlibrary.org/b/OLID/OL12345M.jpg
  static String getBookCover({
    bool isThumbnail = false,
    required String coverKey,
  }) {
    return coverKey.isNotEmpty ? 'https://covers.openlibrary.org/b/OLID/$coverKey-${isThumbnail ? 'S' : 'M'}.jpg' : '';
  }
}
