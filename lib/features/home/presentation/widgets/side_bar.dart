import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:book_catalog/core/widgets/about_me.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../settings/presentation/setting_screen.dart';
import '../screens/favored_screen.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Row(),
          Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              width: .2.sw,
              height: .2.sw,
              child: Image.asset('assets/images/app_icon.png')),
          20.verticalSpace,
          const Text('Welcome To booky'),
          20.verticalSpace,
          Divider(
            color: context.primaryColor,
            thickness: 1.5,
          ),
          20.verticalSpace,
          ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoredScreen()));
              },
              leading: const Icon(Icons.favorite),
              title: Text(LocaleKeys.favoredScreen_favoredBooky.tr()),
              trailing: const Icon(Icons.arrow_forward_ios_rounded)),
          20.verticalSpace,
          ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
              leading: const Icon(Icons.settings),
              title: Text(LocaleKeys.settingScreen_settings.tr()),
              trailing: const Icon(Icons.arrow_forward_ios_rounded)),
          20.verticalSpace,
          ListTile(
              onTap: () {
                BotToast.showText(text: 'Coming Soon');
              },
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded)),
          20.verticalSpace,
          ListTile(
              onTap: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (c) {
                      return const AboutMeDialog();
                    });
              },
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About Me'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded)),
        ],
      ),
    );
  }
}
