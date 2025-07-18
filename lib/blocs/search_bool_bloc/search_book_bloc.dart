import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/book_finder_db.dart';
import '../../models/searched_book_model.dart';
import '../../network/controllers/book_controller.dart';
import '../../utils.dart';

part 'search_book_event.dart';
part 'search_book_state.dart';

/// Bloc responsible for handling book search and retrieving locally stored books.
class SearchBookBloc extends Bloc<SearchBookEvent, SearchBookState> {
  SearchBookBloc() : super(const SearchBookState()) {
    on<Search>(_searchBooks);
    on<FetchStoredBooks>(_fetchStoredBooks);
  }

  int page = 1;

  /// Handles the Search event to fetch books from API based on a query.
  Future<void> _searchBooks(Search event, Emitter<SearchBookState> emit) async {
    Utils.customLog('searchBooks CALLED');

    if (event.paginate) {
      page++;
    } else {
      emit(state.copyWith(status: SearchBookStatus.initial, shouldPaginate: true));
      page = 1;
    }

    if (page != 1 && !state.shouldPaginate) {
      return;
    }

    emit(state.copyWith(status: SearchBookStatus.loading));

    try {
      final response = await BookController().searchBooks(query: event.query.trim(), page: page);

      if (response != null && response.statusCode == 200 && response.data['docs'] != null && response.data['docs'] is List) {
        if ((response.data['docs'] as List).isEmpty) {
          emit(state.copyWith(status: SearchBookStatus.success, shouldPaginate: false));
        }

        if (page == 1) {
          List<SearchedBookModel>? searchResult = searchedBookModelFromJson(jsonEncode(response.data['docs']));

          final List dataToInsertInDB = [];
          for (var e in searchResult) {
            dataToInsertInDB.add(
              {
                BookFinderDb.title: e.title,
                BookFinderDb.coverKey: e.coverEditionKey,
                BookFinderDb.authorName: (e.authorName ?? []).isNotEmpty ? (e.authorName ?? []).first : null,
                BookFinderDb.lendingEditionS: e.lendingEditionS,
              },
            );
          }

          final localDBResponse = await BookFinderDb().insertInBookTable(dataToInsertInDB);
          if (localDBResponse == -1) {
            //
          }

          emit(state.copyWith(status: SearchBookStatus.success, searchResult: searchResult));
        } else {
          final lastData = state.searchResult;
          lastData.addAll(searchedBookModelFromJson(jsonEncode(response.data['docs'])));
          emit(state.copyWith(status: SearchBookStatus.success, searchResult: lastData));
        }
      } else {
        emit(state.copyWith(status: SearchBookStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: SearchBookStatus.failure));
      Utils.customLog(e.toString(), name: 'ERROR at searchBooks');
    }
  }

  /// Handles FetchStoredBooks event to load locally stored book data from the database.
  Future<void> _fetchStoredBooks(FetchStoredBooks event, Emitter<SearchBookState> emit) async {
    Utils.customLog('fetchStoredBooks CALLED');

    emit(state.copyWith(status: SearchBookStatus.loading));

    try {
      final List<SearchedBookModel> fetchedBooks = [];

      final localDBResponse = await BookFinderDb().getAllStoredBooks(page: 1);
      for (var e in localDBResponse) {
        fetchedBooks.add(SearchedBookModel(
          title: e[BookFinderDb.title] ?? '',
          coverEditionKey: e[BookFinderDb.coverKey] ?? '',
          authorName: [(e[BookFinderDb.authorName] ?? '')],
          lendingEditionS: e[BookFinderDb.lendingEditionS] ?? '',
        ));
      }

      emit(state.copyWith(status: SearchBookStatus.success, searchResult: fetchedBooks));
    } catch (e) {
      emit(state.copyWith(status: SearchBookStatus.failure));
      Utils.customLog(e.toString(), name: 'ERROR at fetchStoredBooks');
    }
  }
}
