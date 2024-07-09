import 'package:book_catalog/core/cubit/theme_cubit.dart';
import 'package:book_catalog/core/model/book_model.dart';
import 'package:book_catalog/core/services/shared_preferences_service.dart';
import 'package:book_catalog/features/home/presentation/bloc/home_bloc.dart';
import 'package:book_catalog/features/splash/presentation/splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

import 'core/configs/theme.dart';

void main() async {
  await Hive.initFlutter();
  await SharedPreferencesService.init();
  Hive.registerAdapter(BookModelAdapter());

  await Hive.openBox<BookModel>('books');
  runApp(EasyLocalization(
      path: 'assets/translations',
      saveLocale: true,
      startLocale: Locale(SharedPreferencesService.getLanguage() ?? 'en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          BlocProvider(
            create: (context) => ThemeCubit()..initTheme(),
          ),
        ],
        child: const MainApp(),
      )));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ShowCaseWidget(builder: (context) {
          return ScreenUtilInit(
            splitScreenMode: false,
            designSize: const Size(375, 812),
            child: MaterialApp(
              themeAnimationCurve: Curves.easeInToLinear,
              themeAnimationDuration: Durations.long3,
              debugShowCheckedModeBanner: false,
              builder: BotToastInit(),
              themeMode: state.darkTheme ? ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeManager.darkTheme,
              theme: ThemeManager.lightTheme,
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              home: const SplashScreen(),
            ),
          );
        });
      },
    );
  }
}
