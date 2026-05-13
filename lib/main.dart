import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:global_repository/global_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:settings/settings.dart';
import 'package:speed_share/services/chat_service.dart';
import 'package:speed_share/services/file_service.dart';
import 'package:speed_share_extension/speed_share_extension.dart';
import 'package:window_manager/window_manager.dart';
import 'package:file_manager/file_manager.dart' as file_manager;

import 'services/clipboard_service.dart';
import 'services/desktop_service.dart';
import 'services/discovery_service.dart';
import 'utils/assets_util.dart';
import 'controllers/controllers.dart';
import 'common/config.dart';
import 'root_view.dart';

// 初始化hive的设置
Future<void> initSetting() async {
  String path;
  if (GetPlatform.isIOS) {
    path = (await getApplicationDocumentsDirectory()).path;
  } else {
    path = RuntimeEnvir.configPath;
  }
  // make sure the directory exists
  Directory(path).createSync(recursive: true);
  await initSettingStore(path);
}

bool pop = false;

Future<void> main() async {
  runZonedGuarded<void>(
    () async {
      if (!GetPlatform.isWeb) {
        WidgetsFlutterBinding.ensureInitialized();
        // 拿到应用程序路径
        // get app directory
        final dir = (await getApplicationSupportDirectory()).path;
        RuntimeEnvir.initEnvirWithPackageName(
          Config.packageName,
          appSupportDirectory: dir,
        );
        // 启动文件服务器
        // start file manager server
        // todo 可能需要更改成127.0.0.1
        file_manager.Server.start();
      }
      Get.config(
        enableLog: false,
        logWriterCallback: (text, {isError = false}) {
          // Log.d(text, tag: 'GetX');
        },
      );
      if (!GetPlatform.isWeb) {
        await initSetting();
      }
      Get.put(SettingController());
      Get.put(DeviceController()..init());
      Get.put(ChatController());
      Get.put(FileController());
      Get.put(DownloadController());
      WidgetsFlutterBinding.ensureInitialized();
      if (!GetPlatform.isIOS) {
        String dir;
        if (!GetPlatform.isWeb) {
          dir = (await getApplicationSupportDirectory()).path;
          RuntimeEnvir.initEnvirWithPackageName(
            Config.packageName,
            appSupportDirectory: dir,
          );
        }
      }
      initPersonal();
      runApp(const RootView());
      // 透明状态栏
      // transparent the appbar
      StatusBarUtil.transparent();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        Log.e('Page build exception : ${details.exception}');
      };
      if (GetPlatform.isDesktop) {
        if (!GetPlatform.isWeb) {
          await windowManager.ensureInitialized();
        }
      }
      initApp();
    },
    (error, stackTrace) {
      Log.e('Uncaught exception : $error \n$stackTrace');
    },
  );
}

ClipboardService? clipboard;
DesktopService? desktop;

Future<void> initApp() async {
  Log.v('init');

  if (GetPlatform.isWeb || GetPlatform.isIOS) return;

  if (RuntimeEnvir.packageName != Config.packageName && !GetPlatform.isDesktop) {
    Config.flutterPackage = 'packages/speed_share/';
    Config.package = 'speed_share';
  }

  final view = PlatformDispatcher.instance.implicitView!;
  final pd = view.platformDispatcher;

  Log.i('Current System Locales: ${pd.locales}');
  Log.i('Current System Theme: ${pd.platformBrightness}');
  Log.i('physicalSize:${view.physicalSize.str()}');
  Size dpSize = view.physicalSize / view.devicePixelRatio;
  Log.i('DP Size:${dpSize.str()}');
  Log.i('devicePixelRatio:${view.devicePixelRatio}');
  Log.i('Android DPI:${view.devicePixelRatio * 160}');

  DiscoveryService.instance.init();

  if (!GetPlatform.isMobile && !GetPlatform.isWeb) {
    ClipboardService.instance.init();
    DesktopService.instance.init();
  }
  // prepare file server to provide file transfer
  await FileService.start();
  await ChatService.start();
  String udpData = '';
  udpData += await UniqueUtil.getDevicesId();
  udpData += ',${ChatService.port}';
  // 将设备 ID 与聊天服务器成功创建的端口 UDP 广播出去
  DiscoveryService.instance.startBroadcast(udpData);
  unpackWebResource();
  await initApi('Speed Share', Config.versionName);
  requestManageStorage();
}

extension SizeExt on Size {
  String str() => 'Size(${width.toStringAsFixed(1)}, ${height.toStringAsFixed(1)})';
}

Future<void> requestManageStorage() async {
  if (await Permission.manageExternalStorage.isGranted) {
    Log.i('Permission already granted');
    return;
  }

  final result = await Permission.manageExternalStorage.request();

  if (result.isGranted) {
    Log.i('Permission granted');
  } else {
    Log.i('Permission denied');
  }
}
