import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:book_catalog/features/home/presentation/bloc/home_bloc.dart';
import 'package:book_catalog/features/home/presentation/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_marquee/text_marquee.dart';

import '../../../../core/model/book_model.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({super.key, required this.book});

  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context.read<HomeBloc>().add(DeleteBookEvent(index: book.key));
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(index: book.key)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              elevation: 6,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: book.image == null
                  ? Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      book.image!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          2.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextMarquee(
                book.title,
                style: context.textTheme.titleLarge!,
              ),
            ),
          ),
          2.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextMarquee(
                book.author,
                style: context.textTheme.titleSmall!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
