import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:book_catalog/core/services/shared_preferences_service.dart';
import 'package:book_catalog/features/home/presentation/screens/home_screen.dart';
import 'package:book_catalog/features/intro/data/models/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../home/presentation/bloc/home_bloc.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final pageController = PageController();
  final index = ValueNotifier(0);
  final list = [
    OnboardingData(
        title: 'Welcome to Booky',
        subTitle: 'Your personal book catalog and favorite book organizer!',
        image: 'assets/images/book.png'),
    OnboardingData(
        title: 'Easily Add and Manage Your Books',
        subTitle:
            'Quickly add your favorite books and organize them in one place.',
        image: 'assets/images/add.png'),
    OnboardingData(
        title: 'Mark Your Favorites',
        subTitle: 'Mark books as your favorites and find them easily.',
        image: 'assets/images/favorite.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: context.primaryColor),
        height: 1.sh,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/BG.svg',
                    fit: BoxFit.cover,
                  ),
                  ValueListenableBuilder(
                      valueListenable: index,
                      builder: (context, value, _) {
                        print(value);
                        return Image.asset(
                          list[value].image,
                          width: .5.sw,
                        ).animate(key: UniqueKey()).slideX(begin: 1, end: 0);
                      })
                ],
              ),
            ),
            Container(
              height: .5.sh,
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: context.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  40.verticalSpace,
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                        itemCount: list.length,
                        onPageChanged: (i) {
                          index.value = i;
                        },
                        controller: pageController,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                list[index].title,
                                style: context.textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                              10.verticalSpace,
                              Text(
                                list[index].subTitle,
                                style: context.textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        }),
                  ),
                  const Spacer(),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 2,
                      activeDotColor: context.primaryColor,
                      dotColor: context.primaryColor.withOpacity(.5),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          'Back',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          if (index.value > 0) {
                            pageController.previousPage(
                                duration: Durations.extralong3,
                                curve: Curves.ease);
                          }
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Next',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.primaryColor,
                          ),
                        ),
                        onPressed: () async {
                          if (index.value < list.length - 1) {
                            pageController.nextPage(
                                duration: Durations.extralong3,
                                curve: Curves.ease);
                          } else {
                            context.read<HomeBloc>().add(
                                  AddBookEvent(
                                    title: 'title',
                                    description: 'description',
                                    author: 'author',
                                    publication: DateTime.now(),
                                  ),
                                );
                            SharedPreferencesService.setFirstTime();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
