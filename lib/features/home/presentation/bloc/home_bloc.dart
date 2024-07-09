import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:book_catalog/core/model/book_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    final box = Hive.box<BookModel>('books');
    on<ClearAllDataEvent>((event, emit) async {
      await box.clear();
      emit(HomeState(
          books: box.values.toList(),
          favorites: box.values
              .where(
                (element) => element.favored,
              )
              .toList()));
    });
    on<InitHomeEvent>((event, emit) {
      emit(state.copyWith(books: box.values.toList()));
    });
    on<InitFavoritesEvent>((event, emit) {
      emit(state.copyWith(
          books: box.values.where((element) {
        print(element.favored);
        return element.favored;
      }).toList()));
    });
    on<DeleteBookEvent>((event, emit) async {
      await box.delete(event.index);
      emit(state.copyWith(books: box.values.toList()));
    });
    on<ShowBookEvent>((event, emit) async {
      emit(state.copyWith(book: box.get(event.index)!));
    });
    on<ToggleFavorite>((event, emit) async {
      final item = box.get(event.index)!;
      await box.put(event.index, item.copyWith(favored: !item.favored));
      emit(state.copyWith(
          favorites: box.values.where((e) {
            print(e.favored);
            return e.favored;
          }).toList(),
          book: box.get(event.index),
          books: box.values.toList()));
    });
    on<AddBookEvent>((event, emit) {
      box.add(BookModel(
          title: event.title,
          author: event.author,
          publication: DateTime.now(),
          description: event.description,
          image: event.image));
      emit(state.copyWith(books: box.values.toList()));
    });
    on<EditBookEvent>((event, emit) {
      box.put(
          event.key,
          box.get(event.key)!.copyWith(
              author: event.author,
              publication: event.publication,
              title: event.title,
              description: event.description,
              image: event.image));
      emit(
        state.copyWith(
          books: box.values.toList(),
          book: box.get(event.key),
        ),
      );
    });
  }
}
