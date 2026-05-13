import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_manager/server/file_server.dart' as file_manager;
import 'package:get/get.dart' hide Response;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:path/path.dart' as p;
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/common/config.dart';

import 'package:speed_share/controllers/controllers.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/utils/path_util.dart';

/// Singleton chat server that serves registered files via a single HTTP server.
/// TODO: pure dart
const _tag = 'AnyShareChatServer';

Middleware corsMiddleware() {
  return _corsHandler;
}

Handler _corsHandler(Handler innerHandler) {
  return (request) async {
    if (request.method == 'OPTIONS') {
      return Response.ok(
        null,
        headers: {
          'access-control-allow-origin': '*',
          'access-control-allow-methods': 'GET, HEAD, OPTIONS',
          'access-control-allow-headers': '*',
        },
      );
    }
    final response = await innerHandler(request);
    return response.change(
      headers: {'access-control-allow-origin': '*'},
    );
  };
}

class _ChatService {
  _ChatService._();
  static final _ChatService instance = _ChatService._();
  late final ChatController chatController = Get.find();
  late final SettingController settingController = Get.find();

  final Router _router = Router();
  HttpServer? _server;
  int _port = 0;
  final Set<String> _registeredPaths = {};

  /// Start the HTTP server on [port]. Idempotent — only starts once.
  Future<void> start() async {
    if (_server != null) {
      return;
    }
    var pipeline = const Pipeline();
    _router.get('/ping', (Request request) {
      return Response.ok('pong');
    });
    // TODO: Consider change route path?
    _router.post('/', (Request request) async {
      Map<String, dynamic> data = jsonDecode(await request.readAsString());
      chatController.handleMessage(data);
      // 这儿应该返回本机信息
      return Response.ok(
        "success",
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.text.toString(),
        },
      );
    });
    _router.post('/file_upload', (Request request) async {
      Log.w(request.headers);
      String? fileName = request.headers['filename'];
      if (fileName != null) {
        fileName = utf8.decode(base64Decode(fileName));
        SettingController settingController = Get.find();
        String? downPath = settingController.savePath;
        File file = File(getSafePath('$downPath/$fileName'));
        RandomAccessFile randomAccessFile = await file.open(
          mode: FileMode.write,
        );
        int? fullLength = int.tryParse(request.headers['content-length']!);
        Log.d('fullLength -> $fullLength');
        Completer<bool> lock = Completer();
        // 已经下载的字节长度
        // Already downloaded byte length
        int count = 0;
        DownloadInfo info = DownloadInfo();
        DownloadController downloadController = Get.find();
        final blob = request.headers['blob'];
        downloadController.progress[blob] = info;
        request.read().listen(
          (event) async {
            count += event.length;
            randomAccessFile.writeFromSync(event);
            double progress = count / fullLength!;
            info.count = count;
            info.progress = progress;
            downloadController.update();
            if (progress == 1.0) {
              lock.complete(true);
            }
          },
          onDone: () {},
        );
        await lock.future;
        randomAccessFile.close();
        Log.v('success');
      }
      return Response.ok("success");
    });
    _router.get('/message', (Request request) {
      if (chatController.messageWebCache.isNotEmpty) {
        return Response.ok(jsonEncode(chatController.messageWebCache.removeAt(0)));
      }
      return Response.ok(
        jsonEncode(
          {
            "type": "none",
          },
        ),
      );
    });
    // 返回速享网页的handler
    var webHandler = createStaticHandler(
      RuntimeEnvir.filesPath,
      listDirectories: true,
      defaultDocument: 'index.html',
    );
    _router.mount('/', (r) async {
      // `http://192.168.0.103:12000/sdcard/`的形式，说明是想要访问文件
      if (r.requestedUri.path.startsWith('/sdcard') || file_manager.Server.routes.contains(r.requestedUri.path)) {
        if (!settingController.enableWebServer) {
          return Response.ok(
            l10n.needWSTip,
            headers: {
              HttpHeaders.contentTypeHeader: 'text/plain',
            },
          );
        }
        try {
          Router fileRouter = await file_manager.Server.getFileServerHandler();
          return fileRouter.call(r);
        } catch (e) {
          return Response.notFound(
            e.toString(),
            headers: {
              HttpHeaders.contentTypeHeader: 'text/plain',
            },
          );
        }
      } else {
        // `http://192.168.0.103:12000/`的形式，说明是想要打开速享网页端
        return webHandler(r);
      }
    });
    pipeline = pipeline.addMiddleware(logRequests());
    pipeline = pipeline.addMiddleware(corsMiddleware());
    final handler = pipeline.addHandler(_router);
    _port = Config.chatPortRangeStart;
    while (true) {
      try {
        // TODO:: Test ipv6 does contain ipv4 address or not
        _server = await io.serve(handler, InternetAddress.anyIPv4, _port);
        break;
      } catch (e) {
        Log.w('Port $_port is in use, trying another port...');
        _port = _port + 1;
        if (_port > Config.chatPortRangeEnd) {
          throw Exception('No available ports in the range ${Config.chatPortRangeStart}-${Config.chatPortRangeEnd}');
        }
      }
    }
    Log.i('ChatService started on port $_port', _tag);
  }

  String _normalize(String filePath) {
    String path = filePath.replaceAll('\\', '/');
    path = path.replaceAll(RegExp('^[A-Z]:'), '');
    path = path.replaceAll(RegExp('^/'), '');
    return path;
  }

  /// Register a file to be served. [start] must have been called first.
  /// Returns the URL path segment that can be used to access this file.
  Future<String> addFile(String path) async {
    assert(_server != null, 'FileServer must be started before adding files');

    if (_registeredPaths.contains(path)) {
      return urlFor(path);
    }

    final normalized = _normalize(path);
    final urlPath = p.toUri(normalized).toString();
    final handler = createFileHandler(path, url: urlPath);
    _router.get('/$urlPath', handler);
    _registeredPaths.add(path);

    // log the URL for debugging
    Log.i('Registered file: $path at URL path: /$urlPath');

    return urlPath;
  }

  /// Get the URL path segment for a file path (without registering).
  String urlFor(String path) {
    final normalized = _normalize(path);
    return p.toUri(normalized).toString();
  }

  /// The shelf Router. Exposed so external code can register custom routes
  /// (e.g. token check) before or after the server starts.
  Router get router => _router;

  /// The port the server is running on, or null if not started.
  int? get port => _port;

  /// Number of registered files.
  int get registeredCount => _registeredPaths.length;

  /// Whether the server is running.
  bool get isRunning => _server != null;

  /// Stop the server and clear all registered files.
  Future<void> dispose() async {
    await _server?.close(force: true);
    _server = null;
    _registeredPaths.clear();
  }
}

// ignore: non_constant_identifier_names
final ChatService = _ChatService.instance;
