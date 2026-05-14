import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:global_repository/global_repository.dart';

import 'controllers/controllers.dart';
import 'routes/app_pages.dart';
import 'generated/app_localizations.dart';
import 'themes/theme.dart';

// TODO: 使用路由管理来兼容 Web
class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.find();
    return GetMaterialApp(
      locale: settingController.currentLocale,
      title: '',
      // showPerformanceOverlay: true,
      initialRoute: AppPages.home,
      getPages: AppPages.routes,
      // defaultTransition: GetPlatform.isAndroid ? Transition.fadeIn : null,
      defaultTransition: Transition.native,
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
              return Listener(
                onPointerDown: (event) {
                  if (event.kind == PointerDeviceKind.mouse) {
                    switch (event.buttons) {
                      case kSecondaryMouseButton:
                      case kBackMouseButton:
                        Get.back();
                    }
                  }
                },
                child: ViewMetric(
                  uiWidth: adaptWidth,
                  screenWidth: MediaQuery.of(context).size.width,
                  child: Builder(
                    builder: (context) {
                      ChatController chatController = Get.find();
                      // TODO: Ungraceful!!!
                      chatController.context = context;
                      final bool isDark = Get.rootController.themeMode == ThemeMode.dark;
                      // Theme 中的一些值需要跟随屏幕适配，所以不能直接配置带 MaterialApp 中
                      // Some values in Theme need to follow screen adaptation, so they cannot be directly configured with MaterialApp
                      final ThemeData theme = isDark ? dark(context) : light(context);
                      return GetBuilder<SettingController>(
                        builder: (context) {
                          return Theme(data: theme, child: child!);
                        },
                      );
                    },
                  ),
                ),
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
  }
}
