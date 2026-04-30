import 'package:speed_share/utils/ext_util.dart';

void Function(Null arg)? serverFileFunc;

String getIconFromPath(String path) {
  if (path.isVideo) {
    return 'video';
  } else if (path.isPdf) {
    return 'pdf';
  } else if (path.isDoc) {
    return 'doc';
  } else if (path.isZip) {
    return 'zip';
  } else if (path.isAudio) {
    return 'mp3';
  } else if (path.isImg) {
    return 'other';
  }
  return 'other';
}
