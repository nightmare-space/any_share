import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:global_repository/global_repository.dart';
import 'package:file_manager/file_manager.dart' as file_manager;

import 'package:speed_share/controllers/controllers.dart';
import 'package:speed_share/services/services.dart';
import 'package:speed_share/routes/app_pages.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/themes/theme.dart';
import 'package:speed_share/widgets/switch/xliv_switch.dart';

import 'dialog/select_language.dart';

Future<int> getCacheSize(Directory cacheDir) async {
  int totalSize = 0;

  if (await cacheDir.exists()) {
    try {
      await for (FileSystemEntity entity in cacheDir.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }
    } catch (e) {
      Log.e('Error calculating cache size: $e');
    }
  }

  return totalSize;
}

// 设置页面
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SettingController controller = Get.find();
  ChatController chatController = Get.find();
  String cacheSize = '';
  Directory? cache;

  @override
  void initState() {
    super.initState();
    getp();
  }

  Future<void> getp() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Log.i('directory:${directory.path}');
    Directory doc = await getApplicationDocumentsDirectory();
    Log.i('doc:${doc.path}');
    cache = await getApplicationCacheDirectory();
    Log.i('cache:${cache!.path}');
    getCacheSize(cache!).then((value) {
      Log.d('Cache size: ${value / (1024 * 1024)} MB');
      cacheSize = '${(value / (1024 * 1024)).toStringAsFixed(2)} MB';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle title = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: $(16),
    );
    AppBar? appBar;
    if (ResponsiveBreakpoints.of(context).isMobile) {
      appBar = AppBar(
        title: Text(l10n.setting),
        forceMaterialTransparency: true,
      );
    }
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        left: false,
        child: GetBuilder<SettingController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: $(10)),
                    child: Text(
                      l10n.common,
                      style: title,
                    ),
                  ),
                  GetBuilder<SettingController>(
                    builder: (_) {
                      return SettingItem(
                        onTap: () async {
                          if (GetPlatform.isDesktop) {
                            const confirmButtonText = 'Choose';
                            final path = await getDirectoryPath(
                              confirmButtonText: confirmButtonText,
                            );
                            Log.e('path:$path');
                            if (path != null) {
                              controller.switchDownLoadPath(path);
                            }
                          } else {
                            String? path = await file_manager.FileManager.selectDirectory();
                            if (path != null) {
                              controller.switchDownLoadPath(path);
                            }
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.downlaodPath,
                              style: TextStyle(
                                fontSize: $(18),
                              ),
                            ),
                            Text(
                              controller.savePath!,
                              style: TextStyle(
                                fontSize: $(16),
                                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacityExact(0.6),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SettingItem(
                    onTap: () {
                      Get.dialog(const SelectLang());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.lang,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        Text(
                          controller.currentLocale!.toLanguageTag(),
                          style: TextStyle(
                            fontSize: $(16),
                            color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacityExact(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SettingItem(
                    onTap: () {
                      controller.enableAutoChange(!controller.enableAutoDownloadSetting.value);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.autoDownload,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        AquaSwitch(
                          value: controller.enableAutoDownloadSetting.value,
                          onChanged: controller.enableAutoChange,
                        ),
                      ],
                    ),
                  ),
                  SettingItem(
                    onTap: () {
                      controller.clipChange(!controller.clipboardShareSetting.value);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.clipboardshare,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        AquaSwitch(
                          value: controller.clipboardShareSetting.value,
                          onChanged: controller.clipChange,
                        ),
                      ],
                    ),
                  ),
                  SettingItem(
                    onTap: () {
                      controller.vibrateChange(!controller.vibrate);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.messageNote,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        AquaSwitch(
                          value: controller.vibrate,
                          onChanged: controller.vibrateChange,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: $(10)),
                    child: Text(
                      l10n.fileType,
                      style: title,
                    ),
                  ),
                  SettingItem(
                    onTap: () {
                      controller.changeWebServer(!controller.enableWebServer);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.enableWebServer,
                                style: TextStyle(
                                  fontSize: $(18),
                                ),
                              ),
                              // SizedBox(height: $(2)),
                              Text(
                                l10n.enableWebServerTips,
                                style: TextStyle(
                                  fontSize: $(14),
                                  color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacityExact(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AquaSwitch(
                          value: controller.enableWebServer,
                          onChanged: controller.changeWebServer,
                        ),
                      ],
                    ),
                  ),
                  if (controller.enableWebServer)
                    FutureBuilder<List<String>>(
                      future: PlatformUtil.localAddress(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<Widget> children = [];
                          for (String address in snapshot.data!) {
                            children.add(
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: $(10), vertical: $(2)),
                                child: SelectableText('$address:${ChatService.port}/sdcard'),
                              ),
                            );
                          }
                          return Column(
                            children: children,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: $(10)),
                    child: Text(
                      l10n.clearCache,
                      style: title,
                    ),
                  ),
                  SettingItem(
                    onTap: () async {
                      await cache!.delete(recursive: true);
                      getp();
                      showToast('缓存清理完成');
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${l10n.cacheSize(cacheSize)}: $cacheSize',
                                style: TextStyle(
                                  fontSize: $(18),
                                ),
                              ),
                              Text(
                                l10n.androidSAFTips,
                                style: TextStyle(
                                  fontSize: $(14),
                                  color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacityExact(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: $(8), horizontal: $(10)),
                    child: Text(
                      l10n.aboutSpeedShare,
                      style: title,
                    ),
                  ),
                  SettingItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.privacyAgreement,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: $(16),
                        ),
                      ],
                    ),
                    onTap: () {
                      // AppPages.changeLog
                      Get.toNamed(AppPages.about);
                    },
                  ),
                  SettingItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.changeLog,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: $(16),
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.toNamed(AppPages.changeLog);
                    },
                  ),
                  SettingItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.aboutSpeedShare,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: $(16),
                        ),
                      ],
                    ),
                    onTap: () async {
                      String license = await rootBundle.loadString('LICENSE');
                      Get.toNamed('/about', arguments: license);
                    },
                  ),
                  SettingItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.developer,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        Text(
                          '梦魇兽',
                          style: TextStyle(
                            fontSize: $(18),
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacityExact(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SettingItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // TODO: Move to thanks group
                        Text(
                          l10n.ui,
                          style: TextStyle(
                            fontSize: $(18),
                          ),
                        ),
                        Text(
                          '柚凛/梦魇兽',
                          style: TextStyle(
                            fontSize: $(18),
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacityExact(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  const SettingItem({
    Key? key,
    this.child,
    this.onTap,
  }) : super(key: key);
  final Widget? child;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final $ = context.$;
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $(10), vertical: $(10)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: $(40),
          ),
          child: SizedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class AquaSwitch extends StatelessWidget {
  final bool value;

  final ValueChanged<bool> onChanged;

  final Color? activeColor;

  final Color? unActiveColor;

  final Color? thumbColor;

  const AquaSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.unActiveColor,
    this.thumbColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.78,
      child: XlivSwitch(
        unActiveColor: unActiveColor ?? Theme.of(context).colorScheme.surface4,
        activeColor: Theme.of(context).primaryColor,
        thumbColor: thumbColor,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
