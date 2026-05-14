import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart' hide FileUtil;

import 'package:speed_share/common/assets.dart';
import 'package:speed_share/common/config.dart';
import 'package:speed_share/common/extensions/file_type_ext.dart';
import 'package:speed_share/utils/file_util.dart';

Widget getIconByExt(String path, BuildContext context) {
  final $ = context.$;
  Widget? child;

  if (path.isVideoFile) {
    child = Image.asset(
      'assets/icon/video.png',
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isDocumentFile) {
    child = SvgPicture.asset(
      SvgAssets.doc,
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isArchiveFile) {
    child = SvgPicture.asset(
      SvgAssets.zip,
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isAudioFile) {
    child = SvgPicture.asset(
      SvgAssets.audio,
      width: $(36),
      height: $(36),
      package: Config.package,
    );
  } else if (path.isApkFile) {
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
  } else if (path.isImageFile) {
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
                  // file.svg
                  return SvgPicture.asset(
                    SvgAssets.file,
                    width: $(36),
                    height: $(36),
                    package: Config.package,
                  );
                },
              ),
      ),
    );
  }

  child ??= SvgPicture.asset(
    SvgAssets.file,
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
