import 'package:file_manager/file_manager.dart' as file_manager;
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:speed_share/modules/preview/image_preview.dart';
import 'package:speed_share/modules/preview/video_preview.dart';
import 'package:speed_share/utils/ext_util.dart';

class FileUtil {
  static void openFile(String path) {
    if (path.isImg) {
      Get.to(
        () => PreviewImage(
          path: path,
          tag: path,
        ),
      );
    } else if (path.isVideo) {
      Get.to(
        () => VideoPreview(
          url: path,
        ),
      );
    } else {
      OpenFile.open(path);
    }
  }

  // 获得windows的盘符列表
  // google查下
  // 尽量用ffi调用win32 api
  static List<String> getWindowsDrive() {
    //TODO(ren)
    return [];
  }
}

// 用来选择文件的
Future<List<XFile>?> getFilesForDesktopAndWeb() async {
  final typeGroup = XTypeGroup(
    label: 'images',
    extensions: GetPlatform.isWeb ? [''] : null,
  );
  final files = await openFiles(acceptedTypeGroups: [typeGroup]);
  if (files.isEmpty) {
    return null;
  }
  return files;
}

/// 选择文件路径
Future<List<String?>> getFilesPathsForAndroid(bool useSystemPicker) async {
  List<String> filePaths = [];
  if (!useSystemPicker) {
    filePaths = (await file_manager.FileManager.selectFile());
  } else {
    final List<XFile> files = await openFiles();
    return files.map((e) => e.path).toList();
  }
  return filePaths;
}
