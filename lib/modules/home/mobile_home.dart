import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/modules/file/file_page.dart';
import 'package:speed_share/modules/personal/personal.dart';
import 'package:speed_share/modules/personal/setting/setting_page.dart';
import 'package:speed_share/modules/remote_page.dart';
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
                  if (GetPlatform.isWeb) {
                    return [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: $(8)),
                          child: const ShareChatV2(),
                        ),
                      ),
                      const SizedBox(),
                      const RemotePage(),
                      const FilePage(),
                      const SizedBox(),
                    ][page];
                  }
                  return [
                    const ShareChatV2(),
                    const RemotePage(),
                    const FilePage(),
                    // const PersonalPage(),
                    const SettingPage(),
                  ][page];
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
          onDestinationSelected: (index) {
            page = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(
              icon: Image.asset(
                'assets/icon/homev2_sel.png',
                width: $(24),
                height: $(24),
                color: Theme.of(context).colorScheme.onSurface,
                gaplessPlayback: false,
              ),
              selectedIcon: Image.asset(
                'assets/icon/homev2.png',
                width: $(24),
                height: $(24),
                color: Theme.of(context).colorScheme.onSurface,
                gaplessPlayback: false,
              ),
              label: '首页',
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/icon/remote_file.png',
                width: $(24),
                height: $(24),
                color: page == 1 ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onSurface,
                gaplessPlayback: false,
              ),
              label: '远程文件',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icon/v2/dir.svg',
                width: $(24),
                height: $(24),
                color: page == 2 ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onSurface,
              ),
              label: '本地文件',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: '设置',
            ),
          ],
        ),
      ),
    );
  }
}
