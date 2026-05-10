extension FileTypeExt on String {
  bool get isAudioFile {
    return endsWith('.mp3') || endsWith('.flac');
  }

  bool get isVideoFile {
    return endsWith('.mp4') || endsWith('.mkv') || endsWith('.mov') || endsWith(".avi") || endsWith(".wmv") || endsWith(".rmvb") || endsWith(".mpg") || endsWith(".3gp");
  }

  bool get isApkFile {
    return endsWith('.apk');
  }

  bool get isImageFile {
    return endsWith('.gif') || endsWith('.jpg') || endsWith('.jpeg') || endsWith('.png') || endsWith('.webp');
  }

  bool get isDocumentFile {
    return toLowerCase().endsWith('.doc') || endsWith('.docx') || endsWith('.ppt') || endsWith('.pptx') || endsWith('.pdf') || endsWith('.xls') || endsWith('.xlsx');
  }

  bool get isTextFile {
    return toLowerCase().endsWith('.txt') || endsWith('.md');
  }

  bool get isArchiveFile {
    return endsWith('.zip') || endsWith('.7z') || endsWith('.rar');
  }

  String get fileTypeLabel {
    if (isAudioFile) return '音乐';
    if (isVideoFile) return '视频';
    if (isImageFile) return '图片';
    if (isDocumentFile) return '文档';
    if (isArchiveFile) return '压缩包';
    if (isApkFile) return '安装包';
    return '未知';
  }
}
