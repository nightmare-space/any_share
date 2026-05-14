import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:file_selector/file_selector.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:get/get.dart' hide Response;
import 'package:global_repository/global_repository.dart';

import 'package:speed_share/common/common.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/models/models.dart';
import 'package:speed_share/modules/message_item/message_item.dart';
import 'package:speed_share/utils/utils.dart' hide FileUtil;
import 'package:speed_share/services/services.dart';
import 'controllers.dart';

// TODO: Need Display how much device connected to the chat window's bottom
class ChatController extends GetxController with WidgetsBindingObserver {
  // 列表的滑动控制器
  // scroll view controller
  ScrollController scrollController = ScrollController();
  late final DeviceController deviceController = Get.find();
  late final SettingController settingController = Get.find();

  // TODO: Bad code
  Map<String?, int> dirItemMap = {};
  Map<String?, DirMessage> dirMsgMap = {};
  List<Map<String, dynamic>> cache = [];
  Map<String, XFile> webFileSendCache = {};

  // 储存已经发送过的消息
  // 在第一次连接到设备的时候，会将消息同步过去
  List<Map<String, dynamic>> messageCache = [];
  // 给Web端用的
  List<Map<String, dynamic>> messageWebCache = [];
  // 用来屏幕适配
  // for screen adaptation
  // TODO: Bad code!!!
  late BuildContext context;
  // 输入框用到的焦点
  List<Widget?> backup = [];

  // 用来展示的消息列表
  // message list for display
  // TODO: Convert to List<Widget>
  List<Widget?> messageItems = [];

  Future<void> init() async {
    WidgetsBinding.instance.addObserver(this);
    ChatService.messageHandler = (data) {
      Log.i('handleMessage :$data');
      MessageBaseInfo info = MessageBaseInfo.resolveMessage(data);
      handleMessage(info, messageItems);
    };
    if (GetPlatform.isWeb) {
      // Broswer do not have message server, so we need to simulate the message server by polling
      String urlPrefix = url;
      // remove end slash
      if (urlPrefix.endsWith('/')) {
        urlPrefix = urlPrefix.substring(0, urlPrefix.length - 1);
      }
      // if (!kReleaseMode) {
      //   urlPrefix = 'http://127.0.0.1:12000';
      // }
      Uri uri = Uri.parse(urlPrefix);
      int port = uri.port;
      Device device = Device(
        deviceController.uniqueKey,
        deviceName: deviceController.deviceName,
        deviceType: deviceController.deviceType,
        url: 'http://${uri.host}',
        messagePort: port,
      );
      deviceController.onDeviceConnect(device);
      sendJoinMessageByUrl('http://${uri.host}:$port');
      update();
      Timer.periodic(const Duration(milliseconds: 300), (timer) async {
        try {
          String webUrl = '$urlPrefix${ServerRoutes.message}';
          Response res = await Dio().get(webUrl);
          Map<String, dynamic> data = jsonDecode(res.data);
          MessageBaseInfo info = MessageBaseInfo.resolveMessage(data);
          handleMessage(info, messageItems);
        } catch (_) {}
      });
      return;
    }
  }

  // 通知web浏览器开始上传文件
  // Notify web browser to start upload file
  // TODO: Test on v2.4
  Future<void> notifyBrowserUploadFile(String? hash) async {
    List<String> addresses = await PlatformUtil.localAddress();
    final NotifyMessage notifyMessage = NotifyMessage(
      hash: hash,
      addrs: addresses,
      port: FileService.port,
    );
    messageWebCache.add(notifyMessage.toJson());
  }

  // TODO: Reimplement this
  Future<void> uploadFileForWeb(XFile xFile, String urlPrefix) async {
    try {
      String base64Name = base64Encode(utf8.encode(xFile.name));
      Log.w(base64Name);
      Response response2 = await Dio().post(
        '$urlPrefix${ServerRoutes.uploadFile}',
        data: xFile.openRead(),
        onSendProgress: (count, total) {
          Log.v('count:$count total:$total pro:${count / total}');
        },
        options: Options(headers: {Headers.contentLengthHeader: await xFile.length(), HttpHeaders.contentTypeHeader: ContentType.binary.toString(), 'filename': base64Name, 'blob': xFile.path}),
      );
      Log.w(response2);
    } catch (e) {
      Log.e('Upload file error : $e');
    }
  }

  void sendMessage(MessageBaseInfo info) {
    info.deviceType = deviceController.deviceType;
    info.deviceId = deviceController.uniqueKey;
    messageCache.add(info.toJson());
    messageWebCache.add(info.toJson());
    deviceController.sendToAll(info.toJson());
  }

  // 发送文本消息
  // Send text message
  void sendTextMessage(String content) {
    TextMessage info = TextMessage(content: content, deviceName: deviceController.deviceName);
    sendMessage(info);
    messageItems.add(MessageItemFactory.getMessageItem(info, true, context));
    scrollController.scrollToEnd();
    update();
  }

  // 基于一个文件路径发送消息
  // send a file message base file path
  // TODO: 如果是一次性发出多个文件，消息列表没必要全分隔开
  Future<void> sendFileMessageByPath(String filePath) async {
    FileService.addFile(filePath);
    // 替换windows的路径分隔符
    filePath = filePath.replaceAll('\\', '/');
    // 读取文件大小
    int size = await File(filePath).length();
    // 替换windows盘符
    filePath = filePath.replaceAll(RegExp('^[A-Z]:'), '');
    p.Context pathContext;
    if (GetPlatform.isWindows) {
      pathContext = p.windows;
    } else {
      pathContext = p.posix;
    }
    final FileMessage sendFileInfo = FileMessage(
      filePath: filePath,
      fileName: pathContext.basename(filePath),
      fileSize: FileUtil.formatBytes(size),
      addrs: deviceController.addrs,
      port: FileService.port,
      deviceName: deviceController.deviceName,
    );
    // 发送消息
    sendMessage(sendFileInfo);
    // 将消息添加到本地列表
    messageItems.add(MessageItemFactory.getMessageItem(sendFileInfo, true, context));
    scrollController.scrollToEnd();
    update();
  }

  Future<void> sendFileMessageByXFiles(List<XFile> files) async {
    if (GetPlatform.isWeb) {
      for (XFile xFile in files) {
        Log.w('-' * 10);
        Log.w('xFile.path -> ${xFile.path}');
        Log.w('xFile.name -> ${xFile.name}');
        Log.w('xFile.length -> ${await xFile.length()}');
        Log.w('-' * 10);
        String hash = shortHash(xFile);
        webFileSendCache[hash] = xFile;
        final BrowserFileMessage sendFileInfo = BrowserFileMessage(
          // 用来客户端显示
          fileName: xFile.name,
          hash: hash,
          fileSize: FileUtil.formatBytes(await xFile.length()),
          deviceName: deviceController.deviceName,
          blob: xFile.path,
        );
        // 发送消息
        // socket.send(sendFileInfo.toString());
        sendMessage(sendFileInfo);
        // 将消息添加到本地列表
        messageItems.add(MessageItemFactory.getMessageItem(sendFileInfo, true, context));
        scrollController.scrollToEnd();
        update();
      }
    } else {
      for (XFile xFile in files) {
        Log.d('-' * 10);
        Log.d('xFile.path -> ${xFile.path}');
        Log.d('xFile.name -> ${xFile.name}');
        Log.d('xFile.length -> ${await xFile.length()}');
        Log.d('-' * 10);
        sendFileMessageByPath(xFile.path);
      }
    }
  }

  Future<void> sendDirMessageByPath(String dirPath) async {
    Directory dir = Directory(dirPath);
    String dirName = p.basename(dirPath);
    DirMessage dirMessage = DirMessage(
      dirName: dirName,
      fullSize: 0,
      deviceName: deviceController.deviceName,
      addrs: deviceController.addrs,
      port: FileService.port,
    );
    // 发送消息
    sendMessage(dirMessage);
    // 将消息添加到本地列表
    messageItems.add(MessageItemFactory.getMessageItem(dirMessage, true, context));
    scrollController.scrollToEnd();
    update();
    // TODO 这个功能难用
    // 传相同的文件，得到的文件大小是不一样的
    dir.list(recursive: true).listen((event) async {
      FileSystemEntity entity = event;
      String suffix = '';
      int size = 0;
      if (entity is Directory) {
        suffix = '/';
      } else if (entity is File) {
        size = await entity.length();
        FileService.addFile(entity.path);
      }
      DirPartMessage dirPartMessage = DirPartMessage(path: event.path + suffix, size: size, partOf: dirName);
      sendMessage(dirPartMessage);
      // Log.i(dirPartMessage);
    });
  }

  Future<void> sendJoinMessageByUrl(String url) async {
    Log.i('sendJoinMessage : $url');
    JoinMessage message = JoinMessage();
    message.deviceName = deviceController.deviceName;
    message.deviceId = deviceController.uniqueKey;
    message.addrs = deviceController.addrs;
    message.deviceType = deviceController.deviceType;
    message.filePort = FileService.port;
    message.messagePort = ChatService.port;
    bool allFail = true;
    try {
      Response res = await DioClient.post(
        '$url/',
        data: message.toJson(),
      );
      Log.i('sendJoinMessage result : ${res.data}');
      allFail = false;
    } on DioException catch (_) {}
    if (allFail) {
      Log.e('sendJoinMessage all fail');
    }
  }

  Future<void> sendHistoryMessages(Device device) async {
    for (Map<String, dynamic> data in messageCache) {
      deviceController.send(data, device);
    }
  }

  Future<void> handleMessage(MessageBaseInfo info, List<Widget?> children) async {
    if (info.deviceId == deviceController.uniqueKey) {
      return;
    }
    Log.i('CHatMessage:');
    prettyPrintJson(info.toJson());
    switch (info.runtimeType) {
      // 剪切板消息
      case ClipboardMessage:
        if (!settingController.clipboardShareSetting.value) {
          return;
        }
        ClipboardMessage clipboardMessage = info as ClipboardMessage;
        Clipboard.setData(ClipboardData(text: clipboardMessage.content ?? ''));
        // TODO: 需要重新实现剪切板重复复制的问题
        showToast('${clipboardMessage.deviceName}的剪切板已复制');
        break;
      // 设备加入消息
      case JoinMessage:
        JoinMessage joinMessage = info as JoinMessage;
        // 当连接设备不是本机的时候
        if (info.deviceId != deviceController.uniqueKey) {
          Log.i('current uniqueKey -> ${deviceController.uniqueKey}');
          // 这个不带端口，主要是为了筛选IP
          String? urlPrefix = await getCorrectUrlWithAddressAndPort(joinMessage.addrs!, joinMessage.messagePort);
          Log.i('计算结果:$urlPrefix');
          if (urlPrefix == null) {
            return;
          }
          try {
            // 会先尝试去找是否已经被记录了
            // will try to find object first
            // 连接消息，导致 A 的连接列表不再有 B
            Device device = deviceController.availableDevices().firstWhere((element) => element.id == info.deviceId);
            Log.i('Find device in connectDevice list -> ${device.url}');
            if (!device.sendedHistoryMessage) {
              sendJoinMessageByUrl('$urlPrefix:${joinMessage.messagePort}');
              device.sendedHistoryMessage = true;
            }
            if (!device.sendedHistoryMessage) {
              sendHistoryMessages(device);
              device.sendedHistoryMessage = true;
            }
          } catch (e) {
            Device device = Device(
              info.deviceId,
              deviceName: info.deviceName,
              deviceType: info.deviceType,
              url: urlPrefix,
              messagePort: joinMessage.messagePort,
            );
            sendJoinMessageByUrl('$urlPrefix:${joinMessage.messagePort}');
            sendHistoryMessages(device);
            deviceController.onDeviceConnect(device);
          }
          return;
        }
        break;
      case FileMessage:
        FileMessage fileMessage = info as FileMessage;
        // TODO: 这里不能根据设备列表来计算 url，应该直接用 head 请求来计算，不然因为一些原因，当前设备列表没有目标设备了
        // 文件消息，需要先计算出正确的下载地址
        // File Message need to calculate the correct download url first
        // Get device first
        Device device = deviceController.connectDevice.firstWhere((element) => element.id == fileMessage.deviceId);
        Log.i('Find device in connectDevice list -> ${device.url}');
        fileMessage.url = '${device.url}:${fileMessage.port}';
        Log.i('fileMessage url -> ${fileMessage.url}');
        break;
      case DirMessage:
        // TODO: Reimplement this, the current implementation is too hacky
        DirMessage dirMessage = info as DirMessage;
        // 保存文件夹消息所在的index
        dirItemMap[dirMessage.dirName] = children.length;
        dirMsgMap[dirMessage.dirName] = info;
        String? url = await getCorrectUrlWithAddressAndPort(dirMessage.addrs!, dirMessage.port);
        dirMessage.urlPrifix = '$url:${dirMessage.port}';
        Log.w('dirItemMap -> $dirItemMap');
        break;
      case DirPartMessage:
        DirPartMessage dirPartMessage = info as DirPartMessage;
        if (dirPartMessage.stat == 'complete') {
          Log.i('完成发送');
          dirMsgMap[dirPartMessage.partOf]!.canDownload = true;
          children[dirItemMap[dirPartMessage.partOf]!] = MessageItemFactory.getMessageItem(dirMsgMap[dirPartMessage.partOf], false, context);
          update();
        } else {
          // 下面这行是不断重置文件夹的大小
          dirMsgMap[dirPartMessage.partOf]!.fullSize = dirMsgMap[dirPartMessage.partOf]!.fullSize! + (dirPartMessage.size ?? 0);
          dirMsgMap[dirPartMessage.partOf]!.paths!.add(dirPartMessage.path);
          children[dirItemMap[dirPartMessage.partOf]!] = MessageItemFactory.getMessageItem(dirMsgMap[dirPartMessage.partOf], false, context);
          update();
        }
        return;
      case NotifyMessage:
        NotifyMessage notifyMessage = info as NotifyMessage;
        if (GetPlatform.isWeb) {
          if (webFileSendCache.containsKey(notifyMessage.hash)) {
            Log.e(info);
            String? url = await getCorrectUrlWithAddressAndPort(notifyMessage.addrs!, notifyMessage.port);
            Log.d('uploadFileForWeb url -> $url:${notifyMessage.port}');
            if (url != null) {
              uploadFileForWeb(webFileSendCache[notifyMessage.hash]!, '$url:${notifyMessage.port}');
            } else {
              showToast(l10n.noIPFound);
            }
          }
        }
        return;
      default:
    }
    // 往聊天列表中添加一条消息
    Widget? item = MessageItemFactory.getMessageItem(info, false, context);
    Log.w(info);
    if (item != null) {
      children.add(item);
      // 自动滑动，振动，更新UI
      scrollController.scrollToEnd();
      vibrate();
      update();
    }
  }

  // TODO: Reimplement this
  void restoreList() {
    backup.clear();
    update();
  }

  // TODO: reimplement this
  void changeListToDevice(Device device) {
    backup.clear();
    for (Map map in cache) {
      MessageBaseInfo? info = MessageBaseInfo.resolveMessage(map as Map<String, dynamic>);
      if (info is JoinMessage) {
        continue;
      }
      if (info.deviceType == device.deviceType) {
        handleMessage(info, backup);
      }
    }
  }

  @override
  void onClose() {
    Log.e('chat controller dispose');
    scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        // 刷新本地ip列表
        deviceController.addrs = await DeviceController.localAddress();
        break;
      default:
    }
    // Log.v('didChangeAppLifecycleState : $state');
  }
}

void prettyPrintJson(Object? json) {
  const encoder = JsonEncoder.withIndent('  ');
  Log.i(encoder.convert(json));
}

Future<String?> ping(String url) async {
  Completer<String?> lock = Completer();
  CancelToken cancelToken = CancelToken();
  Response response;
  Future.delayed(const Duration(milliseconds: 3000), () {
    if (!lock.isCompleted) {
      cancelToken.cancel();
    }
  });
  try {
    response = await DioClient.get(
      '$url${ServerRoutes.ping}',
      cancelToken: cancelToken,
    );
    if (!lock.isCompleted) {
      lock.complete(response.data);
    }
    Log.i('$url${ServerRoutes.ping} response ${response.data}');
  } catch (e) {
    if (!lock.isCompleted) {
      lock.complete(null);
    }
  }
  return await lock.future;
}

// Get correct url with address list and port, if no url is correct, return null
// 得到正确的url地址，拿到地址列表和端口，如果没有正确的 url，返回 null
Future<String?> getCorrectUrlWithAddressAndPort(
  List<String?> addresses,
  int? port,
) async {
  for (String? address in addresses) {
    String? token = await ping('http://$address:$port');
    if (token != null) {
      return 'http://$address';
    }
  }
  return null;
}
