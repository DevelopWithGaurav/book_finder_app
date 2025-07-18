import 'package:book_finder_app/helper/book_cover_helper.dart';
import 'package:book_finder_app/network/controllers/book_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBookController extends Mock implements BookController {}

void main() {
  test('getBookCover [isThumbnail = false] test', () {
    expect(
      BookCoverHelper.getBookCover(coverKey: testCoverKey),
      'https://covers.openlibrary.org/b/OLID/$testCoverKey-M.jpg',
    );
  });

  test('getBookCover [isThumbnail = true] test', () {
    expect(
      BookCoverHelper.getBookCover(coverKey: testCoverKey, isThumbnail: true),
      'https://covers.openlibrary.org/b/OLID/$testCoverKey-S.jpg',
    );
  });
}

final testCoverKey = 'OL794927M';
