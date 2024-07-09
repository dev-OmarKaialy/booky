import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:book_catalog/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_marquee/text_marquee.dart';

import '../bloc/home_bloc.dart';
import 'details_screen.dart';

class FavoredScreen extends StatefulWidget {
  const FavoredScreen({super.key});

  @override
  State<FavoredScreen> createState() => _FavoredScreenState();
}

class _FavoredScreenState extends State<FavoredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        centerTitle: true,
        title: Text(
          LocaleKeys.favoredScreen_favoredBooky.tr(),
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        // actions: [
        //   Icon(
        //     Icons.search,
        //     size: 30.sp,
        //     color: Colors.white,
        //   ),
        // ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.all(18.sp),
              child: RefreshIndicator(
                onRefresh: () {
                  context.read<HomeBloc>().add(InitFavoritesEvent());
                  return Future.value();
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .65,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        context
                            .read<HomeBloc>()
                            .add(DeleteBookEvent(index: index));
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(index: index)));
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
                              child: state.favorites[index].image == null
                                  ? Image.asset(
                                      'assets/images/placeholder.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.memory(
                                      state.favorites[index].image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          2.verticalSpace,
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: TextMarquee(
                                state.favorites[index].title,
                                style: context.textTheme.titleLarge!,
                              ),
                            ),
                          ),
                          2.verticalSpace,
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: TextMarquee(
                                state.favorites[index].author,
                                style: context.textTheme.titleSmall!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ));
        },
      ),
    );
  }
}
