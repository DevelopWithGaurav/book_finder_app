part of 'book_details_bloc.dart';

sealed class BookDetailsEvent extends Equatable {
  const BookDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchDetails extends BookDetailsEvent {
  final String lendingEditionS;

  const FetchDetails({required this.lendingEditionS});
}
