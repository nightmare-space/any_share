import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:signale/signale.dart';
import 'package:file_manager/file_manager.dart' as file_manager;

import 'package:speed_share/modules/preview/image_preview.dart';
import 'package:speed_share/modules/preview/video_preview.dart';
import 'package:speed_share/common/extensions/file_type_ext.dart';

class FileUtil {
  static void openFile(String path) {
    if (path.isImageFile) {
      Get.to(
        () => PreviewImage(
          path: path,
          tag: path,
        ),
      );
    } else if (path.isVideoFile) {
      Get.to(
        () => VideoPreview(
          url: path,
        ),
      );
    } else {
      OpenFile.open(path);
    }
  }
}

// 用来选择文件的
Future<List<XFile>?> getFilesForDesktopAndWeb() async {
  final files = await openFiles();
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
    // java.lang.OutOfMemoryError: Failed to allocate a 1073741840 byte allocation with 12582912 free bytes and 252MB until OOM, target footprint 16184304, growth limit 268435456
    // at dev.flutter.packages.file_selector_android.FileSelectorApiImpl.toFileResponse(FileSelectorApiImpl.java:352)
    // at dev.flutter.packages.file_selector_android.FileSelectorApiImpl$2.onResult(FileSelectorApiImpl.java:181)
    // at dev.flutter.packages.file_selector_android.FileSelectorApiImpl$4.onActivityResult(FileSelectorApiImpl.java:306)
    // final List<XFile> files = await openFiles();
    // return files.map((e) => e.path).toList();
    FilePickerResult? result = await FilePicker.pickFiles(
      allowMultiple: true,
      onFileLoading: (p0) {
        Log.i('file picker loading -> $p0');
      },
    );

    if (result != null) {
      filePaths = result.paths.map((e) => e!).toList();
    } else {
      // User canceled the picker
    }
  }
  return filePaths;
}
