import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMeIcon extends StatelessWidget {
  const AboutMeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return const AboutMeDialog();
              });
        },
        child: SvgPicture.asset('assets/images/about.svg'),
      ),
    );
  }
}

class AboutMeDialog extends StatelessWidget {
  const AboutMeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .6,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                      width: 40.sp,
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset('assets/images/app_icon.png')),
                  const Spacer(),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Booky PROJECT',
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'App Version:',
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    '1.0.0',
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Develpoer:',
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    'Omar Kaialy',
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Github:',
                    style: context.textTheme.titleLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('https://github.com/dev-OmarKaialy'));
                    },
                    child: Text(
                      'dev.OmarKaialy',
                      style: TextStyle(
                          fontSize: 12,
                          color: context.theme.colorScheme.onSurface,
                          decoration: TextDecoration.underline,
                          decorationColor: context.theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Telegram Channel:',
                    style: context.textTheme.titleLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('https://t.me/Omar_k_flutter'));
                    },
                    child: Text(
                      '@Omar_k_flutter',
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close',
                      style: context.textTheme.titleMedium?.copyWith(
                          color: context.theme.colorScheme.onSurface))),
            ],
          ),
        ),
      ),
    );
  }
}
