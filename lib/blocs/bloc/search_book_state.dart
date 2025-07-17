part of 'search_book_bloc.dart';

enum SearchBookStatus {
  initial,
  loading,
  success,
  failure,
}

class SearchBookState extends Equatable {
  final SearchBookStatus status;
  final bool shouldPaginate;
  final List<SearchedBookModel> searchResult;
  const SearchBookState({
    this.status = SearchBookStatus.initial,
    this.shouldPaginate = true,
    this.searchResult = const [],
  });

  @override
  List<Object> get props => [status];

  SearchBookState copyWith({
    SearchBookStatus? status,
    final bool? shouldPaginate,
    List<SearchedBookModel>? searchResult,
  }) =>
      SearchBookState(
        status: status ?? this.status,
        shouldPaginate: shouldPaginate ?? this.shouldPaginate,
        searchResult: searchResult ?? this.searchResult,
      );
}
