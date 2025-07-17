class BookCoverHelper {
  static String getBookCover({
    bool isThumbnail = false,
    required String coverKey,
  }) {
    return coverKey.isNotEmpty ? 'https://covers.openlibrary.org/b/OLID/$coverKey-${isThumbnail ? 'S' : 'M'}.jpg' : '';
  }
}
