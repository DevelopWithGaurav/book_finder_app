part of 'search_book_bloc.dart';

abstract class SearchBookEvent extends Equatable {
  const SearchBookEvent();

  @override
  List<Object> get props => [];
}

class Search extends SearchBookEvent {
  final bool paginate;
  final String query;

  const Search({this.paginate = false, required this.query});
}
