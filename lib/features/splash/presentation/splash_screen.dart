import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/services/shared_preferences_service.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../../intro/presentation/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(),
          50.verticalSpace,
          SizedBox(
            width: .6.sw,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'booky',
                style: context.textTheme.headlineLarge
                    ?.copyWith(color: Colors.white),
              ).animate(onComplete: (c) async {
                final firstTime = SharedPreferencesService.getFirstTime();
                if (firstTime != true) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const IntroScreen()
                        .animate()
                        .scale(duration: Durations.medium1);
                  }));
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()
                              .animate()
                              .scale(duration: Durations.medium1)));
                }
              }).shimmer(
                  color: const Color(0xff4B4B5B),
                  duration: Durations.extralong4 * 3),
            ),
          ),
          60.verticalSpace,
          Image.asset(
            'assets/images/intro.png',
          ).animate().fade(duration: Durations.extralong4),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Developed By: Omar Kaialy'),
              Image.asset(
                'assets/images/my_logo.png',
                fit: BoxFit.scaleDown,
                width: 50.sp,
              ).animate().shimmer(
                  duration: Durations.extralong4 * 2,
                  delay: Durations.extralong1,
                  color: Colors.white)
            ],
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
