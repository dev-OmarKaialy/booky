import 'package:book_catalog/core/widgets/yes_no_dialog.dart';
import 'package:book_catalog/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/theme_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final ValueNotifier<String> language;
  @override
  void didChangeDependencies() {
    language = ValueNotifier(context.locale.languageCode);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settingScreen_settings.tr()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(LocaleKeys.settingScreen_theme.tr()),
            trailing: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Switch(
                    value: !state.darkTheme,
                    onChanged: (s) {
                      context.read<ThemeCubit>().changeTheme();
                    });
              },
            ),
          ),
          ListTile(
              title: Text(LocaleKeys.settingScreen_language.tr()),
              trailing: ValueListenableBuilder(
                  valueListenable: language,
                  builder: (context, s, _) {
                    return Switch(
                        value: s == 'ar',
                        onChanged: (s) async {
                          await context.setLocale(
                            Locale(!s ? 'en' : 'ar'),
                          );
                          if (context.mounted) {
                            language.value = context.locale.languageCode;
                          }
                        });
                  })),
          ListTile(
            onTap: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return YesNoDialog(
                        title: LocaleKeys.settingScreen_clearAllData.tr(),
                        onTapYes: () {});
                  });
            },
            title: Text(LocaleKeys.settingScreen_clearData.tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
