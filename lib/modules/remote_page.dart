import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import '../controllers/controllers.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/themes/theme.dart';
import 'widget/header.dart';

/// TODO: 展示出谁在访问哪个文件/文件夹
class RemotePage extends StatefulWidget {
  const RemotePage({Key? key}) : super(key: key);

  @override
  State<RemotePage> createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> {
  Widget? page;
  ChatController chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    page ??= remoteList(context);
    return WillPopScope(
      onWillPop: () async {
        page = remoteList(context);
        setState(() {});
        return false;
      },
      child: PageTransitionSwitcher(
        transitionBuilder:
            (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                fillColor: Colors.transparent,
                child: child,
              );
            },
        duration: const Duration(milliseconds: 600),
        layoutBuilder: (widgets) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              children: widgets,
            ),
          );
        },
        child: page,
      ),
    );
  }

  GetBuilder<DeviceController> remoteList(BuildContext context) {
    return GetBuilder<DeviceController>(
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $(10)),
              child: const Header(),
            ),
            SizedBox(height: $(10)),
            Padding(
              padding: EdgeInsets.all($(10)),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.surface1,
                  borderRadius: BorderRadius.circular($(12)),
                ),
                padding: EdgeInsets.symmetric(horizontal: $(16), vertical: $(14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.remoteAccessFile,
                      style: TextStyle(
                        fontSize: $(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(l10n.remoteAccessDes),
                    SizedBox(
                      height: chatController.addrs.length * $(18),
                      child: ListView.builder(
                        itemCount: chatController.addrs.length,
                        itemBuilder: (context, index) {
                          return SelectableText(
                            'http://${chatController.addrs[index]}:12000/',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.connectDevice.length,
                itemBuilder: (c, i) {
                  Device device = controller.connectDevice[i];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: $(10),
                    ),
                    child: GestureWithScale(
                      onTap: () {
                        Log.i(device);
                        Uri uri = Uri.tryParse(device.url!)!;
                        // TODO: Fix me
                        // page = file_manager.FileManagerView(
                        //   address: 'http://${uri.host}:${fm.Config.port}',
                        //   usePackage: true,
                        //   path: device.deviceType == desktop ? '/Users' : '/sdcard',
                        // );
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: device.deviceColor.withOpacityExact(0.1),
                          borderRadius: BorderRadius.circular($(12)),
                        ),
                        padding: EdgeInsets.all($(24)),
                        margin: EdgeInsets.symmetric(vertical: $(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  device.deviceName!,
                                  style: TextStyle(
                                    fontSize: $(20),
                                    fontWeight: FontWeight.bold,
                                    color: device.deviceColor,
                                  ),
                                ),
                                SizedBox(height: $(10)),
                                Text(
                                  l10n.tapToViewFile(device.deviceName!),
                                  style: TextStyle(color: device.deviceColor),
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomePage1(),
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('首页')),
    Center(child: Text('搜索')),
    Center(child: Text('我的')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: '首页',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search),
              label: '搜索',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }
}
