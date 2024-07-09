import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final DateTime publication;
  @HiveField(3)
  final bool favored;
  @HiveField(4)
  final Uint8List? image;
  @HiveField(5)
  final String description;
  BookModel(
      {required this.title,
      required this.author,
      required this.publication,
      this.favored = false,
      this.description =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vel imperdiet justo. Fusce congue sit amet orci et faucibus. Sed molestie tortor sed mi tempor, at tempor dui tincidunt. Donec posuere scelerisque odio. Integer fringilla magna ante, id aliquam ex volutpat vel. Pellentesque tincidunt arcu at aliquam consequat. Nulla sollicitudin fringilla nibh, quis interdum velit iaculis nec.',
      this.image});

  BookModel copyWith({
    String? title,
    String? author,
    DateTime? publication,
    bool? favored,
    Uint8List? image,
    String? description,
  }) {
    return BookModel(
      title: title ?? this.title,
      author: author ?? this.author,
      publication: publication ?? this.publication,
      favored: favored ?? this.favored,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }
}
