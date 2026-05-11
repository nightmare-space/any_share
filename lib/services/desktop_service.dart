import 'dart:ui';

import 'package:get/get.dart';
import 'package:signale/signale.dart';
import 'package:speed_share/common/assets.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class DesktopService with WindowListener {
  DesktopService._();

  static final DesktopService instance = DesktopService._();

  final TrayHandler trayHandler = TrayHandler();

  void init() {
    trayManager.addListener(trayHandler);
    windowManager.addListener(this);
  }

  @override
  void onWindowClose() {
    windowManager.hide();
    windowManager.setSkipTaskbar(false);
  }
}

class TrayHandler with TrayListener {
  bool isForegroung = true;
  TrayHandler() {
    if (!GetPlatform.isMobile && !GetPlatform.isWeb) {
      initTray();
    }
  }

  Future<void> initTray() async {
    await trayManager.setIcon(
      SvgAssets.appIcon,
    );
    Menu menu = Menu(
      items: [
        MenuItem(
          key: 'show_window',
          label: l10n.open,
        ),
        MenuItem.separator(),
        MenuItem(
          key: 'exit_app',
          label: l10n.close,
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  @override
  Future<void> onTrayIconMouseDown() async {
    // do something, for example pop up the menu
    if (isForegroung) {
      windowManager.hide();
    } else {
      windowManager.show();
      Log.i(await trayManager.getBounds());
      // windowManager.setBounds(await trayManager.getBounds());
      Rect? rect = await trayManager.getBounds();
      Offset offset = Offset(rect!.left - 760, rect.top);
      windowManager.setPosition(offset);
    }
    isForegroung = !isForegroung;
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
    // do something
  }

  @override
  void onTrayIconRightMouseUp() {
    // do something
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'show_window') {
      windowManager.show();
      windowManager.setSkipTaskbar(false);
      // do something
    } else if (menuItem.key == 'exit_app') {
      windowManager.destroy();
      // do something
    }
  }
}
