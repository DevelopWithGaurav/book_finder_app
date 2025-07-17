import 'package:flutter/material.dart';

import '../../common/extensions.dart';
import '../../helper/book_cover_helper.dart';
import '../../models/searched_book_model.dart';
import '../../utils.dart';
import '../../widgets/custom_image.dart';
import '../book_details/book_details_screen.dart';

class SearchedItemWidget extends StatelessWidget {
  const SearchedItemWidget({super.key, required this.requiredItem});

  final SearchedBookModel requiredItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (requiredItem.lendingEditionS.isValid && requiredItem.coverEditionKey.isValid) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(
                        lendingEditionS: (requiredItem.authorName ?? []).isNotEmpty ? (requiredItem.lendingEditionS ?? '') : '',
                        authorName: (requiredItem.authorName ?? []).first,
                        coverKey: requiredItem.coverEditionKey ?? '',
                        title: requiredItem.title ?? 'NA',
                      )));
        } else {
          Utils.customToastLong('Details not available!');
        }
      },
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
