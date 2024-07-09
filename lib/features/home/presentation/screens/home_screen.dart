import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:book_catalog/core/services/shared_preferences_service.dart';
import 'package:book_catalog/features/home/presentation/screens/details_screen.dart';
import 'package:book_catalog/features/home/presentation/widgets/add_book_dialog.dart';
import 'package:book_catalog/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/widgets/no_data.dart';
import '../bloc/home_bloc.dart';
import '../widgets/book_widget.dart';
import '../widgets/side_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _oneKey = GlobalKey();
  final _secondKey = GlobalKey();
  final _thirdKey = GlobalKey();
  final drawerController = AwesomeDrawerBarController();

  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(InitHomeEvent());
    WidgetsBinding.instance.addPostFrameCallback((s) {
      if (SharedPreferencesService.getShowCase() == null) {
        Future.delayed(Durations.extralong1, () {
          ShowCaseWidget.of(context).startShowCase([_oneKey]);
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      isRTL: context.locale == const Locale('ar'),
      controller: drawerController,
      menuScreen: const SideBar(),
      mainScreen: Scaffold(
        appBar: AppBar(
          backgroundColor: context.primaryColor,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              drawerController.toggle?.call();
            },
            child: const Icon(Icons.menu_rounded),
          ),
          title: Text(
            'booky',
            style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () {
                context.read<HomeBloc>().add(InitHomeEvent());
                return Future.value();
              },
              child: state.books.isEmpty
                  ? NoData(
                      title: LocaleKeys.homeScreen_nodata.tr(),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(20.sp),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .65,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20),
                      itemCount: state.books.length,
                      itemBuilder: (_, index) {
                        return Builder(builder: (context) {
                          return SharedPreferencesService.getShowCase() == true
                              ? BookWidget(
                                  book: state.books[index],
                                )
                              : Showcase(
                                  key: _secondKey,
                                  disposeOnTap: true,
                                  onTargetClick: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                                index: state.books[index]
                                                    .key))).whenComplete(() {
                                      ShowCaseWidget.of(context)
                                          .startShowCase([_thirdKey]);
                                    });
                                  },
                                  description:
                                      LocaleKeys.homeScreen_showcase2.tr(),
                                  child: Showcase(
                                      key: _thirdKey,
                                      disposeOnTap: false,
                                      onTargetClick: () {},
                                      onTargetLongPress: () async {
                                        context.read<HomeBloc>().add(
                                            DeleteBookEvent(
                                                index: state.books[index].key));
                                        ShowCaseWidget.of(context).dismiss();
                                        await SharedPreferencesService
                                            .setShowCase();
                                      },
                                      description:
                                          LocaleKeys.homeScreen_showcase4.tr(),
                                      disableBarrierInteraction: true,
                                      showArrow: true,
                                      child: BookWidget(
                                          book: state.books[index])));
                        });
                      },
                    ),
            );
          },
        ),
        floatingActionButton: Showcase(
          key: _oneKey,
          description: LocaleKeys.homeScreen_showcase1.tr(),
          disableBarrierInteraction: true,
          showArrow: true,
          disposeOnTap: true,
          onTargetClick: () {
            ShowCaseWidget.of(context).startShowCase([_secondKey]);
          },
          child: FloatingActionButton(
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return const AddBookDialog();
                },
              );
            },
            child: Icon(
              Icons.add,
              size: 30.sp,
            ),
          ),
        ),
      ),
    );
  }
}
