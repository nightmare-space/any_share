import 'package:clipboard_watcher/clipboard_watcher.dart' show ClipboardListener, clipboardWatcher;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signale/signale.dart';
import 'package:speed_share/controllers/controllers.dart';
import 'package:speed_share/models/models.dart';

class ClipboardService with ClipboardListener {
  ClipboardService._();

  static final ClipboardService instance = ClipboardService._();

  late final ChatController chatController = Get.find();
  late final SettingController settingController = Get.find();
  late final DeviceController deviceController = Get.find();

  void init() {
    clipboardWatcher.addListener(this);
    clipboardWatcher.start();
  }

  @override
  void onClipboardChanged() async {
    if (!settingController.clipboardShareSetting.value) return;

    final data = await Clipboard.getData(Clipboard.kTextPlain);

    Log.i('监听到本机的剪切板:${data?.text}');

    chatController.sendMessage(
      ClipboardMessage(
        content: data?.text ?? "",
        deviceName: deviceController.deviceName,
      ),
    );
  }

  void setClipboard(String? text) {
    Log.i('手动设置剪切板消息:$text');

    chatController.sendMessage(
      ClipboardMessage(
        content: text ?? "",
        deviceName: deviceController.deviceName,
      ),
    );
  }
}
