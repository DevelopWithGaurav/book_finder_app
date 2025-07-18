import 'package:book_finder_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/book_details_bloc/book_details_bloc.dart';
import '../../common/platform_specific_alert_dialog.dart';
import '../../constants.dart';
import '../../widgets/custom_shimmer.dart';
import 'cover_section.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.authorName, required this.coverKey, required this.lendingEditionS, required this.title});

  final String lendingEditionS;
  final String authorName;
  final String coverKey;
  final String title;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Utils.customLog(widget.lendingEditionS, name: 'lendingEditionS');
    Utils.customLog(widget.authorName, name: 'authorName');
    Utils.customLog(widget.coverKey, name: 'coverKey');

    context.read<BookDetailsBloc>().add(FetchDetails(lendingEditionS: widget.lendingEditionS));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CoverSection(coverKey: widget.coverKey),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Constants.kDefaultPadding),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.authorName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              height: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Constants.kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(),
                  BlocConsumer<BookDetailsBloc, BookDetailsState>(
                    listener: (context, state) {
                      if (state.status == BookDetailsStatus.failure) {
                        PlatformSpecificAlertDialog.show(
                          context: context,
                          title: 'Opps!',
                          content: 'Something went wrong! Please try again after some time.',
                        ).then((_) => Navigator.pop(context));
                      }
                    },
                    builder: (context, state) {
                      return state.status == BookDetailsStatus.loading
                          ? CustomShimmer(
                              child: Container(
                                height: 150,
                                width: double.maxFinite,
                                color: Colors.amber,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.details?.description ?? 'Not Available!'),
                                const SizedBox(height: 16),
                                Text(
                                  'Publish Date',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(state.details?.publishDate ?? 'Not Available!'),
                              ],
                            );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
