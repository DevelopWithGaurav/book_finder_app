import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/search_bool_bloc/search_book_bloc.dart';
import '../../constants.dart';
import '../../generated/assets.dart';
import '../../utils.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_shimmer.dart';
import '../../widgets/empty_event_widget.dart';
import 'searched_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if ((_searchController.text).length >= 3) {
          context.read<SearchBookBloc>().add(Search(query: _searchController.text, paginate: true));
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Book')),
      body: RefreshIndicator(
        onRefresh: () async {
          if ((_searchController.text).length >= 3) {
            context.read<SearchBookBloc>().add(Search(query: _searchController.text));
          }
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Constants.kDefaultPadding),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if ((value).length >= 3) {
                      context.read<SearchBookBloc>().add(Search(query: _searchController.text));
                    }
                  },
                  onSubmitted: (value) {
                    if ((value).length >= 3) {
                      context.read<SearchBookBloc>().add(Search(query: _searchController.text));
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    hintText: 'Search by title',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            BlocConsumer<SearchBookBloc, SearchBookState>(
              listener: (context, state) {
                if (state.status == SearchBookStatus.failure) {
                  Utils.customToastLong('Something went wrong!');
                }
              },
              builder: (context, state) {
                return state.status == SearchBookStatus.loading && state.searchResult.isEmpty
                    ? SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverList.builder(
                          itemCount: 10,
                          itemBuilder: (_, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(Constants.kDefaultRadius),
                              child: CustomShimmer(
                                child: Container(
                                  height: 80,
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(bottom: 16),
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : state.searchResult.isEmpty
                        ? SliverToBoxAdapter(
                            child: const EmptyEventWidget(
                              lottiePath: Assets.assetsLottiesEmptySearch,
                              label: 'No book found!',
                            ),
                          )
                        : SliverList.builder(
                            itemCount: state.status == SearchBookStatus.loading && state.searchResult.isNotEmpty ? state.searchResult.length + 1 : state.searchResult.length,
                            itemBuilder: (_, index) {
                              if (state.status == SearchBookStatus.loading && state.searchResult.isNotEmpty && index == state.searchResult.length) {
                                return const Align(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )),
                                  ),
                                );
                              }

                              final requiredItem = state.searchResult[index];

                              return SearchedItemWidget(requiredItem: requiredItem);
                            },
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}
