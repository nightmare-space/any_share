import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:global_repository/global_repository.dart';

import 'package:speed_share/common/assets.dart';
import 'package:speed_share/modules/personal/setting/setting_page.dart';
import 'package:speed_share/modules/share_chat_window.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Builder(
                builder: (context) {
                  return PageTransitionSwitcher(
                    transitionBuilder:
                        (
                          Widget child,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                        ) {
                          return FadeThroughTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            child: child,
                          );
                        },
                    child: [
                      const ShareChatV2(),
                      const SettingPage(),
                    ][page],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: page,
          backgroundColor: Theme.of(context).colorScheme.surface,
          onDestinationSelected: (index) {
            page = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                SvgAssets.message,
                width: $(24),
                height: $(24),
                color: Theme.of(context).primaryColor,
              ),
              label: '首页',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                SvgAssets.setting,
                width: $(24),
                height: $(24),
                color: Theme.of(context).primaryColor,
              ),
              label: '设置',
            ),
          ],
        ),
      ),
    );
  }
}
