part of 'home_bloc.dart';

class HomeState {
  final List<BookModel> books;
  final List<BookModel> favorites;
  final BookModel? book;
  HomeState({
    this.books = const [],
    this.favorites = const [],
    this.book,
  });

  HomeState copyWith({
    List<BookModel>? books,
    List<BookModel>? favorites,
    BookModel? book,
  }) {
    return HomeState(
      books: books ?? this.books,
      favorites: favorites ?? this.favorites,
      book: book ?? this.book,
    );
  }
}
