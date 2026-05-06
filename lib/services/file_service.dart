import 'dart:io';

import 'package:global_repository/global_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:path/path.dart' as p;

/// Singleton file server that serves registered files via a single HTTP server.
///
/// Usage:
/// ```dart
/// await FileServer.instance.start(port: 8080);
/// final urlPath = FileServer.instance.addFile('/path/to/file.txt');
/// // Accessible at http://<ip>:8080/<urlPath>
/// ```
const _tag = 'AnyShareFileServer';

Middleware corsMiddleware() {
  return _corsHandler;
}

Handler _corsHandler(Handler innerHandler) {
  return (request) async {
    if (request.method == 'OPTIONS') {
      return Response.ok(null, headers: {
        'access-control-allow-origin': '*',
        'access-control-allow-methods': 'GET, HEAD, OPTIONS',
        'access-control-allow-headers': '*',
      });
    }
    final response = await innerHandler(request);
    return response.change(
      headers: {'access-control-allow-origin': '*'},
    );
  };
}

class _FileServer {
  _FileServer._internal();
  static final _FileServer _instance = _FileServer._internal();
  static _FileServer get instance => _instance;

  final Router _router = Router();
  HttpServer? _server;
  int? _port;
  final Set<String> _registeredPaths = {};

  /// Start the HTTP server on [port]. Idempotent — only starts once.
  Future<void> start({required int port}) async {
    if (_server != null) {
      return;
    }
    _port = port;
    _router.get('/ping', (Request request) {
      return Response.ok('pong');
    });
    var pipeline = const Pipeline();
    pipeline = pipeline.addMiddleware(logRequests());
    pipeline = pipeline.addMiddleware(corsMiddleware());
    final handler = pipeline.addHandler(_router);
    _server = await io.serve(
      handler,
      InternetAddress.anyIPv4,
      port,
      shared: true,
    );
    Log.i('FileServer started on port $port', _tag);
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
    _port = null;
    _registeredPaths.clear();
  }
}

// ignore: non_constant_identifier_names
final FileServer = _FileServer.instance;
