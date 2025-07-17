import 'package:flutter/material.dart';

import '../../helper/book_cover_helper.dart';
import '../../models/searched_book_model.dart';
import '../../widgets/custom_image.dart';

class SearchedItemWidget extends StatelessWidget {
  const SearchedItemWidget({super.key, required this.requiredItem});

  final SearchedBookModel requiredItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 55,
        width: 40,
        child: CustomImage(
          path: BookCoverHelper.getBookCover(coverKey: requiredItem.coverEditionKey ?? '', isThumbnail: true),
          fit: BoxFit.cover,
        ),
      ),
      title: Text(requiredItem.title ?? 'NA'),
      subtitle: Text(
        'by ${(requiredItem.authorName ?? []).isNotEmpty ? (requiredItem.authorName ?? []).first : 'NA'}',
      ),
    );
  }
}
