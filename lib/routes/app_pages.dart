import 'package:flutter/material.dart';

import 'package:file_manager/view/file_manager_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/common/assets.dart';
import 'package:speed_share/common/config.dart';

import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/modules/adaptive/adapive_entry.dart';
import 'package:speed_share/themes/theme.dart';

Debouncer _doublePopdebouncer = Debouncer(delay: const Duration(seconds: 1));
int _time = 0;

class AppPages {
  AppPages._();
  static const home = '/home';
  static const about = '/about';
  static const changeLog = '/change_log';
  static const setting = '/setting';

  static final routes = [
    GetPage(
      name: '/file',
      page: () => const ThemeWrapper(
        child: FileManagerPage(),
      ),
    ),
    GetPage(
      name: home,
      page: () => Builder(
        builder: (context) {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              if (_time == 0) {
                _time++;
                showToast(l10n.backAgainTip);
              } else {
                Navigator.of(context).pop();
              }
              _doublePopdebouncer.call(() {
                _time = 0;
              });
            },
            child: const AdaptiveEntryPoint(),
          );
        },
      ),
    ),
    GetPage(
      name: about,
      page: () {
        return Builder(
          builder: (context) {
            final $ = context.$;
            return AboutPage(
              applicationName: l10n.appName,
              appVersion: Config.versionName,
              versionCode: Config.versionCode,
              logo: Padding(
                padding: EdgeInsets.only(top: $(32)),
                child: SizedBox(
                  width: $(100),
                  height: $(100),
                  child: SvgPicture.asset(
                    SvgAssets.appIcon,
                    width: $(100),
                    height: $(100),
                  ),
                ),
              ),
              otherVersionLink: 'https://bkkj.run/apps/AnyShare/',
              openSourceLink: 'https://github.com/nightmare-space/any_share',
              license: Get.arguments,
              canOpenDrawer: false,
            );
          },
        );
      },
    ),

    // ChangeLogPage
    GetPage(
      name: changeLog,
      page: () => ChangeLogPage(
        icon: SizedBox(
          child: Builder(
            builder: (context) {
              final $ = context.$;
              return Padding(
                padding: EdgeInsets.all($(4)),
                child: SvgPicture.asset(
                  SvgAssets.appIcon,
                ),
              );
            },
          ),
        ),
      ),
    ),
  ];
}

class ThemeWrapper extends StatelessWidget {
  const ThemeWrapper({
    Key? key,
    this.child,
  }) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final ThemeData theme = isDark ? dark(context) : light(context);
    return Theme(
      data: theme,
      child: child!,
    );
  }
}
