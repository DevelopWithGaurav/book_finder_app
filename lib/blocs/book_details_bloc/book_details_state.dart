part of 'book_details_bloc.dart';

enum BookDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class BookDetailsState extends Equatable {
  final BookDetailsStatus status;
  final BookDetailModel? details;
  const BookDetailsState({
    this.status = BookDetailsStatus.initial,
    this.details,
  });

  @override
  List<Object> get props => [status];

  BookDetailsState copyWith({
    BookDetailsStatus? status,
    BookDetailModel? details,
  }) =>
      BookDetailsState(
        status: status ?? this.status,
        details: details ?? this.details,
      );
}
