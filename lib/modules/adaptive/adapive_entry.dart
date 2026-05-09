import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:signale/signale.dart';

import 'package:speed_share/controllers/controllers.dart';
import 'package:speed_share/modules/home/desktop_home.dart';
import 'package:speed_share/modules/home/mobile_home.dart';

// 自动响应布局
class AdaptiveEntryPoint extends StatefulWidget {
  const AdaptiveEntryPoint({
    Key? key,
  }) : super(key: key);

  @override
  State<AdaptiveEntryPoint> createState() => _AdaptiveEntryPointState();
}

class _AdaptiveEntryPointState extends State<AdaptiveEntryPoint> {
  ChatController chatController = Get.put(ChatController());
  String? address;

  @override
  void initState() {
    super.initState();
    if (!GetPlatform.isWeb) {
      chatController.createChatRoom();
    } else {
      chatController.initChat();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isDesktop) {
      Log.i('AdaptiveEntryPoint is desktop');
      return const DesktopHome();
    }
    Log.i('AdaptiveEntryPoint is mobile');
    return const MobileHome();
  }
}
