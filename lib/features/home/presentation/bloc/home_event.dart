part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitHomeEvent extends HomeEvent {}

class InitFavoritesEvent extends HomeEvent {}

class AddBookEvent extends HomeEvent {
  final String title;
  final String description;
  final String author;
  final Uint8List? image;
  final DateTime publication;
  AddBookEvent({
    required this.title,
    required this.description,
    required this.author,
    this.image,
    required this.publication,
  });
}

class EditBookEvent extends HomeEvent {
  final int key;
  final String? title;
  final String? description;
  final String? author;
  final Uint8List? image;
  final DateTime? publication;
  EditBookEvent({
    required this.key,
    this.title,
    this.description,
    this.author,
    this.image,
    this.publication,
  });
}

class DeleteBookEvent extends HomeEvent {
  final int index;
  DeleteBookEvent({required this.index});
}

class ShowBookEvent extends HomeEvent {
  final int index;
  ShowBookEvent({required this.index});
}

class ToggleFavorite extends HomeEvent {
  final int index;
  ToggleFavorite({
    required this.index,
  });
}
