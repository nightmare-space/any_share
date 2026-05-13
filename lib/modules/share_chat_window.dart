import 'dart:math';

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:global_repository/global_repository.dart' hide GestureWithScale;
import 'package:image_picker/image_picker.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:speed_share/common/assets.dart';
import 'package:speed_share/common/device_type_extension.dart';
import 'package:speed_share/controllers/controllers.dart';
import 'package:speed_share/modules/widget/menu.dart';
import 'package:speed_share/services/chat_service.dart';
import 'package:speed_share/utils/scan_util.dart';
import 'package:speed_share/common/config.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/themes/theme.dart';

import 'dialog/show_qr_page.dart';
import 'widget/gesture.dart';

// 聊天窗口
class ShareChatV2 extends StatefulWidget {
  const ShareChatV2({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _ShareChatV2State();
}

class _ShareChatV2State extends State<ShareChatV2> with SingleTickerProviderStateMixin {
  ChatController chatController = Get.find();
  late AnimationController menuAnim;
  int index = 0;
  // 输入框控制器
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    menuAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    menuAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        left: false,
        child: Column(
          children: [
            if (ResponsiveBreakpoints.of(context).isMobile) appbar(context) else SizedBox(height: $(10)),
            Expanded(
              child: Row(
                children: [
                  if (ResponsiveBreakpoints.of(context).isMobile) leftNav(),
                  chatBody(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded chatBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $(0)),
        child: Column(
          children: [
            Expanded(child: chatList(context)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: $(64), maxHeight: $(246)),
                  child: sendMsgContainer(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector chatList(BuildContext context) {
    return GestureDetector(
      onTap: () {
        chatController.focusNode.unfocus();
      },
      child: Material(
        borderRadius: BorderRadius.circular($(10)),
        color: Theme.of(context).colorScheme.surfaceContainer,
        clipBehavior: Clip.antiAlias,
        child: GetBuilder<ChatController>(
          builder: (context) {
            List<Widget?> children = [];
            if (chatController.backup.isNotEmpty) {
              children = chatController.backup;
            } else {
              children = chatController.children;
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB($(0), $(0), $(0), $(80)),
              controller: chatController.scrollController,
              itemCount: children.length,
              cacheExtent: 99999,
              itemBuilder: (c, i) {
                return (children)[i];
              },
            );
          },
        ),
      ),
    );
  }

  SizedBox leftNav() {
    return SizedBox(
      width: $(64),
      child: Material(
        child: Column(
          children: [
            SizedBox(height: $(4)),
            LeftNav(value: index),
          ],
        ),
      ),
    );
  }

  Widget appbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $(12)),
      child: Material(
        color: colorScheme.surface,
        child: SizedBox(
          height: $(48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.allDevices,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: bold,
                  fontSize: $(16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NiIconButton(
                    onTap: () {
                      ScanUtil.parseScan();
                    },
                    child: SvgPicture.asset(
                      SvgAssets.qrCodeScan,
                      color: Theme.of(context).colorScheme.onSurface,
                      width: $(24),
                    ),
                  ),
                  NiIconButton(
                    onTap: () {
                      Get.dialog(
                        ShowQRPage(port: ChatService.port),
                      );
                    },
                    child: SvgPicture.asset(
                      SvgAssets.qrCode,
                      color: Theme.of(context).colorScheme.onSurface,
                      width: $(24),
                    ),
                    // child: Image.asset(
                    //   'assets/icon/qr.png',
                    //   width: $(20),
                    //   package: Config.package,
                    //   color: Theme.of(context).colorScheme.onSurface,
                    // ),
                  ),
                  NiIconButton(
                    onTap: () {
                      Get.dialog(
                        HeaderMenu(
                          offset: Offset(MediaQuery.of(context).size.width, 40),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      SvgAssets.ellipsisVertical,
                      color: Theme.of(context).colorScheme.onSurface,
                      width: $(24),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return AnimatedBuilder(
      animation: menuAnim,
      builder: (c, child) {
        return SizedBox(
          height: $(100) * menuAnim.value,
          child: child,
        );
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: $(16)),
        physics: const NeverScrollableScrollPhysics(),
        child: Wrap(
          children: [
            SizedBox(
              width: $(80),
              height: $(80),
              child: InkWell(
                borderRadius: BorderRadius.circular($(10)),
                onTap: () {
                  menuAnim.reverse();
                  Future.delayed(const Duration(milliseconds: 100), () async {
                    final ImagePicker picker = ImagePicker();
                    final List<XFile> photos = await picker.pickMultiImage();
                    for (var photo in photos) {
                      chatController.sendFileFromPath(photo.path);
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SvgAssets.img,
                      width: $(36),
                      height: $(36),
                      color: Theme.of(context).primaryColor,
                      package: Config.package,
                    ),
                    SizedBox(height: $(4)),
                    Text(
                      '图片',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: bold,
                        fontSize: $(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: $(80),
              height: $(80),
              child: InkWell(
                borderRadius: BorderRadius.circular($(10)),
                onTap: () {
                  menuAnim.reverse();
                  Future.delayed(const Duration(milliseconds: 100), () async {
                    final ImagePicker picker = ImagePicker();
                    final List<XFile> videos = await picker.pickMultiVideo();
                    for (var video in videos) {
                      chatController.sendFileFromPath(video.path);
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SvgAssets.video,
                      width: $(36),
                      height: $(36),
                      color: Theme.of(context).primaryColor,
                      package: Config.package,
                    ),
                    SizedBox(height: $(4)),
                    Text(
                      '视频',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: bold,
                        fontSize: $(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: $(80),
              height: $(80),
              child: InkWell(
                borderRadius: BorderRadius.circular($(10)),
                onTap: () {
                  menuAnim.reverse();
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (GetPlatform.isDesktop || GetPlatform.isWeb) {
                      chatController.sendFileForBroswerAndDesktop();
                    } else if (GetPlatform.isAndroid) {
                      chatController.sendFileForAndroid(
                        useSystemPicker: true,
                      );
                    }
                  });
                },
                child: Tooltip(
                  message: l10n.systemManagerTips,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgAssets.file,
                        width: $(36),
                        height: $(36),
                        color: Theme.of(context).primaryColor,
                        package: Config.package,
                      ),
                      SizedBox(height: $(4)),
                      Text(
                        '文件',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: bold,
                          fontSize: $(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: $(80),
              height: $(80),
              child: InkWell(
                borderRadius: BorderRadius.circular($(10)),
                onTap: () {
                  menuAnim.reverse();
                  Future.delayed(const Duration(milliseconds: 100), () {
                    chatController.sendDir();
                  });
                },
                child: Tooltip(
                  message: l10n.systemManagerTips,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgAssets.dir,
                        width: $(36),
                        height: $(36),
                        color: Theme.of(context).primaryColor,
                        package: Config.package,
                      ),
                      SizedBox(height: $(4)),
                      Text(
                        '文件夹',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: bold,
                          fontSize: $(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sendMsgContainer(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (ctl) {
        return Material(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular($(12)),
            topRight: Radius.circular($(12)),
          ),
          color: colorScheme.surface,
          child: Padding(
            padding: EdgeInsets.fromLTRB($(0), $(8), $(8), 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular($(12)),
                        ),
                        width: double.infinity,
                        child: Center(
                          child: GetBuilder<ChatController>(
                            builder: (_) {
                              return TextField(
                                focusNode: chatController.focusNode,
                                controller: chatController.controller,
                                autofocus: false,
                                maxLines: 8,
                                minLines: 1,
                                keyboardType: GetPlatform.isDesktop ? TextInputType.text : TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: l10n.chatInputHint,
                                ),
                                onSubmitted: (_) {
                                  if (chatController.inputMultiline) {
                                    chatController.controller.value = TextEditingValue(
                                      text: '${chatController.controller.text}\n',
                                      selection: TextSelection.collapsed(
                                        offset: chatController.controller.selection.end + 1,
                                      ),
                                    );
                                    chatController.focusNode.requestFocus();
                                    return;
                                  }
                                  chatController.sendTextMsg();
                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    chatController.focusNode.requestFocus();
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: $(8)),
                    GestureWithScale(
                      onTap: () {
                        if (chatController.hasInput) {
                          chatController.sendTextMsg();
                        } else {
                          if (menuAnim.isCompleted) {
                            menuAnim.reverse();
                          } else {
                            menuAnim.forward();
                          }
                        }
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular($(24)),
                        // borderOnForeground: true,
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: SizedBox(
                          width: $(46),
                          height: $(46),
                          child: AnimatedBuilder(
                            animation: menuAnim,
                            builder: (c, child) {
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateZ(menuAnim.value * pi / 4),
                                child: child,
                              );
                            },
                            child: Icon(
                              chatController.hasInput ? Icons.send : Icons.add,
                              size: $(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: $(4)),
                  ],
                ),
                SizedBox(height: $(4)),
                menu(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LeftNav extends StatefulWidget {
  const LeftNav({
    Key? key,
    this.value,
  }) : super(key: key);
  final int? value;

  @override
  State<LeftNav> createState() => _LeftNavState();
}

class _LeftNavState extends State<LeftNav> with SingleTickerProviderStateMixin {
  DeviceController deviceController = Get.find();
  ChatController chatController = Get.find();
  late AnimationController controller;
  late Animation offset;
  int? index;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    offset = Tween<double>(begin: 0, end: 0).animate(controller);
    index = widget.value;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: $(10)),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (context, c) {
                  return SizedBox(
                    height: offset.value,
                  );
                },
              ),
              Stack(
                children: [
                  Material(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: SizedBox(
                      height: $(10),
                      width: $(64),
                    ),
                  ),
                  Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular($(12)),
                    ),
                    child: SizedBox(
                      height: $(10),
                      width: $(64),
                    ),
                  ),
                ],
              ),
              Container(
                height: $(48),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular($(12)),
                    bottomLeft: Radius.circular($(12)),
                  ),
                ),
              ),
              Stack(
                children: [
                  Material(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: SizedBox(
                      height: $(10),
                      width: $(60),
                    ),
                  ),
                  Material(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular($(12)),
                    ),
                    child: SizedBox(
                      height: $(10),
                      width: $(60),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: $(10),
            ),
            MenuButton(
              value: 0,
              enable: index == 0,
              child: SvgPicture.asset(
                SvgAssets.message,
                width: $(36),
                height: $(36),
                color: Theme.of(context).primaryColor,
                package: Config.package,
              ),
              onChange: (value) {
                index = value;
                offset = Tween<double>(begin: offset.value, end: $(0)).animate(controller);
                chatController.restoreList();
                controller.reset();
                controller.forward();
                setState(() {});
              },
            ),
            GetBuilder<DeviceController>(
              builder: (_) {
                return Column(
                  children: [
                    for (int i = 0; i < deviceController.connectDevice.length; i++)
                      MenuButton(
                        value: i + 1,
                        enable: index == i + 1,
                        child: SvgPicture.asset(
                          deviceController.connectDevice[i].deviceType!.iconPath,
                          width: $(32),
                          height: $(32),
                          package: Config.package,
                          color: colorScheme.onSurface,
                        ),
                        onChange: (value) {
                          index = value;
                          offset = Tween<double>(
                            begin: offset.value,
                            end: (i + 1) * $(60),
                          ).animate(controller);
                          controller.reset();
                          controller.forward();
                          chatController.changeListToDevice(deviceController.connectDevice[i]);
                          setState(() {});
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    this.enable = true,
    this.value,
    this.onChange,
    this.child,
  }) : super(key: key);
  final bool enable;
  final int? value;
  final void Function(int? index)? onChange;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final $ = context.$;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ChatController controller = Get.find();
            controller.focusNode.unfocus();
            onChange?.call(value);
          },
          child: SizedBox(
            width: $(60),
            child: Padding(
              padding: EdgeInsets.only(
                left: $(10),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular($(10)),
                  bottomLeft: Radius.circular($(10)),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular($(10)),
                      ),
                      width: $(48),
                      height: $(48),
                      child: Center(
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: $(12),
        ),
      ],
    );
  }
}
