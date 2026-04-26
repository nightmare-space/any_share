import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:global_repository/global_repository.dart' hide FileUtil;
import 'package:speed_share/config/config.dart';
import 'package:speed_share/utils/ext_util.dart';
import 'package:speed_share/utils/file_util.dart';

Widget getIconByExt(String path, BuildContext context) {
  final $ = context.$;
  Widget? child;

  if (path.isVideo) {
    child = Image.asset(
      'assets/icon/video.png',
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isPdf) {
    child = Image.asset(
      'assets/icon/pdf.png',
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isDoc) {
    child = Image.asset(
      'assets/icon/doc.png',
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isZip) {
    child = Image.asset(
      'assets/icon/zip.png',
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isAudio) {
    child = Image.asset(
      'assets/icon/mp3.png',
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isApk) {
    if (GetPlatform.isDesktop) {
      return const Icon(Icons.adb);
    }
    // TODO: Reimplement me, get icon from apk file
    // String filePath = Uri.parse(path).path;
    // child = Image.network(
    //   'http://127.0.0.1:${(AppChannel()).getPort()}/icon?path=$filePath',
    //   gaplessPlayback: true,
    //   width: $(36),
    //   height: $(36),
    //   fit: BoxFit.cover,
    //   errorBuilder: (_, __, ___) {
    //     return const SizedBox();
    //   },
    // );
  } else if (path.isImg) {
    return Hero(
      tag: path,
      child: GestureDetector(
        onTap: () {
          FileUtil.openFile(path);
        },
        child: path.startsWith('http')
            ? Image(
                width: $(36),
                height: $(36),
                fit: BoxFit.cover,
                image: ResizeImage(
                  NetworkImage(path),
                  width: 100,
                ),
              )
            : Image(
                image: ResizeImage(
                  FileImage(File(path)),
                  width: 100,
                ),
                width: $(36),
                height: $(36),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/icon/other.png',
                    width: $(36),
                    height: $(36),
                    package: Config.package,
                  );
                },
              ),
      ),
    );
  }

  child ??= Image.asset(
    'assets/icon/other.png',
    width: $(36),
    height: $(36),
    package: Config.package,
  );
  return GestureDetector(
    onTap: () {
      FileUtil.openFile(path);
    },
    child: child,
  );
}
