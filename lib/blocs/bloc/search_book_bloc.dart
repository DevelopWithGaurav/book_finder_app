import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/searched_book_model.dart';
import '../../network/controllers/search_controller.dart';
import '../../utils.dart';

part 'search_book_event.dart';
part 'search_book_state.dart';

class SearchBookBloc extends Bloc<SearchBookEvent, SearchBookState> {
  SearchBookBloc() : super(const SearchBookState()) {
    on<Search>(_searchBooks);
  }

  int page = 1;

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
      final response = await SearchBookController().searchBooks(query: event.query.trim(), page: page);

      if (response != null && response.statusCode == 200 && response.data['docs'] != null && response.data['docs'] is List) {
        if ((response.data['docs'] as List).isEmpty) {
          emit(state.copyWith(status: SearchBookStatus.success, shouldPaginate: false));
        }

        if (page == 1) {
          emit(state.copyWith(status: SearchBookStatus.success, searchResult: searchedBookModelFromJson(jsonEncode(response.data['docs']))));
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
}
