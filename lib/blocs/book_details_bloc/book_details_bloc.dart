import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book_detail_model.dart';
import '../../network/controllers/book_controller.dart';
import '../../utils.dart';

part 'book_details_event.dart';
part 'book_details_state.dart';

/// Bloc class to handle book detail fetching logic using BLoC architecture.
class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  BookDetailsBloc() : super(const BookDetailsState()) {
    on<FetchDetails>(_fetchDetails);
  }

  /// Handles the FetchDetails event to retrieve book detail from API.
  Future<void> _fetchDetails(FetchDetails event, Emitter<BookDetailsState> emit) async {
    Utils.customLog('fetchDetails CALLED');

    emit(state.copyWith(status: BookDetailsStatus.loading));

    try {
      final response = await BookController().fetchBookDetails(lendingEditionS: event.lendingEditionS);

      if (response != null && response.statusCode == 200 && response.data != null) {
        emit(state.copyWith(status: BookDetailsStatus.success, details: bookDetailModelFromJson(jsonEncode(response.data))));
      } else {
        emit(state.copyWith(status: BookDetailsStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: BookDetailsStatus.failure));
      Utils.customLog(e.toString(), name: 'ERROR at fetchDetails');
    }
  }
}
