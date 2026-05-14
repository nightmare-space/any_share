import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'package:global_repository/global_repository.dart';

import 'package:speed_share/common/common.dart';

/// 解压 web 资源，可以在浏览器访问速享页面，不仅仅是简单的 HTML 页面
/// Unpack web resources, allowing access to the AnyShare page in the browser, not just a simple HTML page
Future<void> unpackWebResource() async {
  ByteData byteData = await rootBundle.load(
    '${Config.flutterPackage}assets/web.zip',
  );
  final Uint8List list = byteData.buffer.asUint8List();
  // Decode the Zip file
  final archive = ZipDecoder().decodeBytes(list);
  // Extract the contents of the Zip archive to disk.
  for (final file in archive) {
    final filename = file.name;
    if (file.isFile) {
      final data = file.content as List<int>;
      File wfile = File('${RuntimeEnvir.filesPath}/$filename');
      await wfile.create(recursive: true);
      await wfile.writeAsBytes(data);
    } else {
      await Directory('${RuntimeEnvir.filesPath}/$filename').create(
        recursive: true,
      );
    }
  }
}
