import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/common/device_type.dart';
import '../controllers/controllers.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/speed_share.dart';

class DesktopDrawer extends StatefulWidget {
  const DesktopDrawer({
    Key? key,
    this.value,
    this.onChange,
  }) : super(key: key);

  final dynamic value;
  final void Function(int value)? onChange;

  @override
  State<DesktopDrawer> createState() => _DesktopDrawerState();
}

class _DesktopDrawerState extends State<DesktopDrawer> {
  String getIcon(DeviceType? type) {
    switch (type) {
      case DeviceType.phone:
        return 'assets/icon/phone.png';
      case DeviceType.desktop:
        return 'assets/icon/computer.png';
      case DeviceType.browser:
        return 'assets/icon/browser.png';
      default:
        return 'assets/icon/computer.png';
    }
  }

  ChatController chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all($(12)),
            child: Row(
              children: [
                GetBuilder<DeviceController>(
                  builder: (controller) {
                    if (GetPlatform.isWeb) {
                      return Column(
                        children: [
                          messageMenu(),
                          fileMenu(),
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (personHeader != null)
                          Column(
                            children: [
                              SizedBox(
                                width: $(200),
                                child: personHeader,
                              ),
                              SizedBox(height: $(8)),
                            ],
                          ),
                        homeMenu(),
                        messageMenu(),
                        fileMenu(),
                        localFileMenu(controller),
                        settingMenu(controller),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: MediaQuery.of(context).size.height,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }

  DrawerItem settingMenu(DeviceController controller) {
    return DrawerItem(
      groupValue: widget.value,
      value: controller.connectDevice.length + 3,
      onChange: (v) {
        setState(() {});
        widget.onChange?.call(v);
      },
      builder: (context) {
        return Row(
          children: [
            // Image.asset(
            //   'assets/icon/setting.png',
            //   color: Theme.of(context).textTheme.bodyMedium!.color,
            //   width: $(16),
            // ),
            SvgPicture.asset(
              'assets/icon/v2/setting.svg',
              width: $(16),
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            SizedBox(width: $(4)),
            Text(
              l10n.setting,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        );
      },
    );
  }

  DrawerItem localFileMenu(DeviceController controller) {
    return DrawerItem(
      groupValue: widget.value,
      value: controller.connectDevice.length + 2,
      onChange: (v) {
        setState(() {});
        widget.onChange?.call(v);
      },
      builder: (context) {
        return Row(
          children: [
            SvgPicture.asset(
              'assets/icon/v2/folder.svg',
              width: $(16),
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            SizedBox(width: $(4)),
            Text(
              l10n.fileManagerLocal,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        );
      },
    );
  }

  GetBuilder<DeviceController> fileMenu() {
    return GetBuilder<DeviceController>(
      builder: (dc) {
        return Column(
          children: [
            for (int i = 0; i < dc.connectDevice.length; i++)
              DrawerItem(
                groupValue: widget.value,
                value: i + 2,
                onChange: (v) {
                  widget.onChange?.call(v);
                  chatController.changeListToDevice(dc.connectDevice[i]);
                  setState(() {});
                },
                builder: (context) {
                  return Row(
                    children: [
                      Image.asset(
                        getIcon(dc.connectDevice[i].deviceType),
                        width: $(16),
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      SizedBox(width: $(4)),
                      Text(
                        '${l10n.fileManager}(${dc.connectDevice[i].deviceName})',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        );
      },
    );
  }

  DrawerItem messageMenu() {
    return DrawerItem(
      groupValue: widget.value,
      value: 1,
      onChange: (v) {
        setState(() {});
        chatController.restoreList();
        widget.onChange?.call(v);
      },
      builder: (context) {
        return Row(
          children: [
            SvgPicture.asset(
              'assets/icon/v2/message.svg',
              width: $(16),
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            // Image.asset(
            //   'assets/icon/all.png',
            //   width: $(16),
            //   color: Theme.of(context).textTheme.bodyMedium!.color,
            // ),
            SizedBox(width: $(4)),
            Text(
              l10n.chatWindow,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        );
      },
    );
  }

  DrawerItem homeMenu() {
    return DrawerItem(
      groupValue: widget.value,
      value: 0,
      onChange: (v) {
        setState(() {});
        widget.onChange?.call(v);
      },
      builder: (context) {
        return Row(
          children: [
            Image.asset(
              'assets/icon/homev2.png',
              width: $(16),
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            SizedBox(width: $(4)),
            Text(
              l10n.home,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        );
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    this.groupValue,
    this.value,
    this.builder,
    this.onChange,
  }) : super(key: key);
  final dynamic groupValue;
  final dynamic value;
  final WidgetBuilder? builder;
  final void Function(int value)? onChange;
  bool get enable => groupValue == value;
  @override
  Widget build(BuildContext context) {
    final $ = context.$;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        onChange?.call(value);
      },
      borderRadius: BorderRadius.circular($(8)),
      child: Container(
        width: $(200),
        padding: EdgeInsets.symmetric(
          horizontal: $(12),
          vertical: $(12),
        ),
        decoration: BoxDecoration(
          // TODO(lin): Check 0.11 opacity
          color: enable ? Theme.of(context).primaryColor.withOpacityExact(0.11) : null,
          borderRadius: BorderRadius.circular($(8)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                color: enable ? Theme.of(context).primaryColor : (isDark ? Colors.white : Colors.black),
              ),
            ),
          ),
          child: Builder(
            builder: builder!,
          ),
        ),
      ),
    );
  }
}
