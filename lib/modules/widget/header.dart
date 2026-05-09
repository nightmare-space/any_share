import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';

import 'package:global_repository/global_repository.dart';
import 'package:speed_share/common/device_type_extension.dart';
import 'package:speed_share/controllers/controllers.dart';
import 'package:speed_share/generated/l10n.dart';

/// 主页显示的最上面那个header
class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.showAddress = true,
  }) : super(key: key);
  final bool showAddress;

  @override
  Widget build(BuildContext context) {
    final $ = context.$;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(width: $(4)),
              SizedBox(width: $(4)),
              const HeaderSwiper(),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderSwiper extends StatefulWidget {
  const HeaderSwiper({Key? key}) : super(key: key);

  @override
  State<HeaderSwiper> createState() => _HeaderSwiperState();
}

class _HeaderSwiperState extends State<HeaderSwiper> {
  ChatController controller = Get.find();
  DeviceController deviceController = Get.find();
  late Timer timer;
  int page = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      page += 1;
      page = page % 2;
      if (page == 1) {
        DeviceController deviceController = Get.find();
        if (deviceController.availableDevices().isEmpty) {
          page = 0;
        }
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
        child: [
          Align(
            alignment: Alignment.centerLeft,
            child: GetBuilder<DeviceController>(
              builder: (_) {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: l10n.headerNotice(deviceController.availableDevice()),
                        style: TextStyle(
                          fontSize: $(16),
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              GetBuilder<DeviceController>(
                builder: (controller) {
                  List<Widget> children = [];
                  for (Device device in controller.availableDevices()) {
                    children.add(
                      Material(
                        color: device.deviceType?.deviceColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular($(8)),
                        child: SizedBox(
                          height: $(32),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: $(8)),
                            child: Center(
                              child: Text(device.deviceName!),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    child: Row(
                      children: children,
                    ),
                  );
                },
              ),
            ],
          ),
        ][page],
      ),
    );
  }
}
