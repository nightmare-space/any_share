import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/common/assets.dart';
import 'package:speed_share/routes/app_pages.dart';
import '../controllers/controllers.dart';
import 'package:speed_share/generated/l10n.dart';

class DesktopDrawer extends StatefulWidget {
  const DesktopDrawer({
    Key? key,
    required this.value,
    this.onChange,
  }) : super(key: key);

  final String value;
  final void Function(String value)? onChange;

  @override
  State<DesktopDrawer> createState() => _DesktopDrawerState();
}

class _DesktopDrawerState extends State<DesktopDrawer> {
  ChatController chatController = Get.find();
  late final colorScheme = Theme.of(context).colorScheme;

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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        homeMenu(),
                        settingMenu(controller),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingMenu(DeviceController controller) {
    return DrawerItemv2(
      groupValue: widget.value,
      value: AppPages.setting,
      onChange: (v) {
        setState(() {});
        widget.onChange?.call(v);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            SvgAssets.setting,
            width: $(16),
            color: colorScheme.onSurface,
          ),
          SizedBox(width: $(4)),
          Text(
            l10n.setting,
            style: TextStyle(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget homeMenu() {
    return DrawerItemv2(
      groupValue: widget.value,
      value: AppPages.home,
      onChange: (v) {
        setState(() {});
        widget.onChange?.call(v);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            SvgAssets.message,
            width: $(16),
            color: colorScheme.onSurface,
          ),
          SizedBox(width: $(4)),
          Text(
            l10n.home,
            style: TextStyle(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
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

class DrawerItemv2<T> extends StatefulWidget {
  const DrawerItemv2({
    required this.value,
    required this.child,
    this.groupValue,
    this.onChange,
    super.key,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChange;
  final Widget child;

  @override
  State<DrawerItemv2<T>> createState() => _DrawerItemv2State<T>();
}

class _DrawerItemv2State<T> extends State<DrawerItemv2<T>> {
  @override
  Widget build(BuildContext context) {
    final $ = context.$;
    final isSelected = widget.value == widget.groupValue;
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        widget.onChange?.call(widget.value);
      },
      borderRadius: BorderRadius.circular($(8)),
      child: Container(
        width: $(200),
        padding: EdgeInsets.symmetric(
          horizontal: $(12),
          vertical: $(12),
        ),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacityExact(0.11) : null,
          borderRadius: BorderRadius.circular($(8)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                color: isSelected ? colorScheme.primary : colorScheme.onSurface.withOpacityExact(0.7),
              ),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
