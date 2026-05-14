import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:settings/settings.dart';
import 'package:global_repository/global_repository.dart';

import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/speed_share.dart';

/// 支持切换的语言列表
Map<String, Locale> languageMap = {
  "English": const Locale('en', ''),
  "中文": const Locale('zh', 'CN'),
  "Spanish": const Locale('es', ''),
};

// 管理设置的controller
class SettingController extends GetxController {
  SettingController() {
    if (!GetPlatform.isWeb) {
      initConfig();
    }
  }

  /// 开启自动下载
  Setting enableAutoDownloadSetting = 'enableAutoDownload'.setting;

  /// 开启剪切板共享
  Setting clipboardShareSetting = 'clipboardShare'.setting;

  @Deprecated('Const Island is deprecated')
  Setting enbaleConstIslandSetting = 'enbaleConstIsland'.setting;

  /// 开启消息振动
  bool vibrate = true;
  Setting vibrateSetting = 'vibrate'.setting;

  /// 开启文件分类
  bool enableFileClassify = false;
  Setting enableFileClassifySetting = 'enableFileClassify'.setting;
  bool enableWebServer = false;
  Setting enableWebServerSetting = 'enableWebServer'.setting;

  void changeFileClassify(bool value) {
    enableFileClassifySetting.set(value);
    enableFileClassify = value;
    update();
  }

  void changeWebServer(bool value) {
    enableWebServer = value;
    update();
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (!isVIP) {
          showToast(l10n.vipTips);
          enableWebServer = !value;
          update();
        } else {
          enableWebServerSetting.set(value);
        }
      },
    );
  }

  /// 文件储存路径
  String? savePath;
  SettingNode savePathSetting = 'savePath'.setting;

  Locale? currentLocale = const Locale('zh', 'CN');
  String? currentLocaleKey = '中文';
  SettingNode currentLocaleSetting = 'lang'.setting;

  void switchLanguage(String? key) {
    currentLocaleKey = key;
    currentLocaleSetting.set(key);
    currentLocale = languageMap[key];
    Get.updateLocale(currentLocale!);
    update();
  }

  // 初始化配置
  void initConfig() {
    Stopwatch stopwatch = Stopwatch()..start();
    if (clipboardShareSetting.value == null) {
      clipboardShareSetting.set(true);
    }
    vibrate = vibrateSetting.get() ?? true;
    if (enableAutoDownloadSetting.value == null) {
      enableAutoDownloadSetting.set(false);
    }
    enableFileClassify = enableFileClassifySetting.get() ?? false;
    enableWebServer = enableWebServerSetting.get() ?? false;
    currentLocaleKey = currentLocaleSetting.get() ?? '中文';
    currentLocale = languageMap[currentLocaleKey];
    Log.i('Settings init in ${stopwatch.elapsedMilliseconds} ms');
    String defaultPath = '/sdcard/SpeedShare';
    if (GetPlatform.isWindows || GetPlatform.isWeb) {
      defaultPath = '${dirname(Platform.resolvedExecutable)}/SpeedShare';
    }
    savePath = savePathSetting.get() ?? defaultPath;
  }

  void clipChange(bool value) {
    clipboardShareSetting.set(value);
    update();
  }

  void vibrateChange(bool value) {
    vibrate = value;
    vibrateSetting.set(value);
    update();
  }

  void enableAutoChange(bool value) {
    enableAutoDownloadSetting.set(value);
    update();
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        // TODO: Remove
        if (!isVIP) {
          showToast(l10n.vipTips);
          enableAutoDownloadSetting.set(!value);
          update();
        } else {
          enableAutoDownloadSetting.set(value);
        }
      },
    );
  }

  void switchDownLoadPath(String path) {
    savePath = path;
    savePathSetting.set(path);
    update();
  }
}
