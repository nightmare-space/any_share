import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'app/controller/controller.dart';
import 'app/routes/app_pages.dart';
import 'generated/app_localizations.dart';
import 'themes/theme.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initRoute = SpeedPages.initial;
    SettingController settingController = Get.find();
    return GetBuilder<SettingController>(
      builder: (context) {
        return GetMaterialApp(
          locale: settingController.currentLocale,
          title: '',
          initialRoute: initRoute,
          getPages: SpeedPages.routes,
          defaultTransition: GetPlatform.isAndroid ? Transition.fadeIn : null,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          builder: (context, child) {
            return ResponsiveBreakpoints.builder(
              child: Builder(
                builder: (context) {
                  double adaptWidth = 0;
                  if (ResponsiveBreakpoints.of(context).isDesktop | ResponsiveBreakpoints.of(context).isTablet) {
                    adaptWidth = 896;
                  } else {
                    adaptWidth = 414;
                  }
                  return ViewMetric(
                    uiWidth: adaptWidth,
                    screenWidth: MediaQuery.of(context).size.width,
                    child: Builder(builder: (context) {
                      ChatController chatController = Get.find();
                      chatController.context = context;
                      // ignore: deprecated_member_use
                      final bool isDark = window.platformBrightness == Brightness.dark;
                      final ThemeData theme = isDark ? dark(context) : light(context);
                      return GetBuilder<SettingController>(
                        builder: (context) {
                          return Theme(
                            data: theme,
                            child: child!,
                          );
                        },
                      );
                    }),
                  );
                },
              ),
              breakpoints: const [
                Breakpoint(start: 0, end: 500, name: MOBILE),
                Breakpoint(start: 500, end: double.infinity, name: DESKTOP),
              ],
              breakpointsLandscape: [
                const Breakpoint(start: 0, end: 500, name: MOBILE),
                const Breakpoint(start: 500, end: double.infinity, name: DESKTOP),
              ],
            );
          },
        );
      },
    );
  }
}
