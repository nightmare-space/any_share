import 'dart:io';

import 'package:global_repository/global_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:path/path.dart' as p;
import 'package:speed_share/common/config.dart';

/// Singleton file server that serves registered files via a single HTTP server.
/// TODO: pure dart and add test
const _tag = 'AnyShareFileServer';

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

/// TODO: Consider use isolate to server every file
class _FileService {
  _FileService._internal();
  static final _FileService _instance = _FileService._internal();
  static _FileService get instance => _instance;

  final Router _router = Router();
  HttpServer? _server;
  int _port = 0;
  int get port => _port;
  final Set<String> _registeredPaths = {};

  /// Start the HTTP server on [port]. Idempotent — only starts once.
  Future<void> start() async {
    if (_server != null) {
      return;
    }
    var pipeline = const Pipeline();
    pipeline = pipeline.addMiddleware(logRequests());
    pipeline = pipeline.addMiddleware(corsMiddleware());
    final handler = pipeline.addHandler(_router);
    int rangeStart = Config.shelfPortRangeStart;
    int rangeEnd = Config.shelfPortRangeEnd;
    _port = rangeStart;
    while (true) {
      try {
        _server = await io.serve(handler, InternetAddress.anyIPv6, _port);
        break;
      } catch (e) {
        Log.w('Port $_port is in use, trying another port...');
        _port = _port + 1;
        if (_port > rangeEnd) {
          throw Exception('No available ports in the range $rangeStart-$rangeEnd');
        }
      }
    }
    Log.i('FileServer started on port $_port', _tag);
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
final FileService = _FileService.instance;
