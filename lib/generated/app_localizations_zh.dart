// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get common => '常规';

  @override
  String get setting => '设置';

  @override
  String get downlaodPath => '下载路径';

  @override
  String get autoDownload => '自动下载';

  @override
  String get clipboardshare => '剪切板共享';

  @override
  String get messageNote => '收到消息振动提醒';

  @override
  String get aboutSpeedShare => '关于速享';

  @override
  String get currenVersion => '当前版本';

  @override
  String get otherVersion => '其他版本下载';

  @override
  String get downloadTip => '速享还支持Windows、macOS、Linux';

  @override
  String get lang => '语言';

  @override
  String get chatWindow => '消息窗口';

  @override
  String get developer => '开发者';

  @override
  String get openSource => '开源地址';

  @override
  String get inputConnect => '输入连接';

  @override
  String get scan => '扫描二维码';

  @override
  String get log => '日志';

  @override
  String get theTermsOfService => '服务条款';

  @override
  String get privacyAgreement => '隐私政策';

  @override
  String get qrTips => '左右滑动切换IP地址';

  @override
  String get ui => 'UI设计师';

  @override
  String get recentFile => '最近文件';

  @override
  String get recentImg => '最近图片';

  @override
  String get currentRoom => '聊天房间';

  @override
  String get remoteAccessFile => '远程访问本机文件';

  @override
  String get remoteAccessDes => '在浏览器打开以下IP地址，即可远程管理本机文件';

  @override
  String get directory => '文件夹';

  @override
  String get unknownFile => '未知文件';

  @override
  String get zip => '压缩包';

  @override
  String get doc => '文档';

  @override
  String get music => '音乐';

  @override
  String get video => '视频';

  @override
  String get image => '图片';

  @override
  String get apk => '安装包';

  @override
  String get appName => '速享';

  @override
  String headerNotice(num number) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: '有$number个设备连接',
      zero: '当前未连接任何设备',
    );
    return '$_temp0';
  }

  @override
  String get recentConnect => '最近连接';

  @override
  String get empty => '空';

  @override
  String get projectBoard => '魇系列项目面板';

  @override
  String get joinQQGroup => '加入交流反馈群';

  @override
  String get changeLog => '更新日志';

  @override
  String get about => 'About Speed Share';

  @override
  String get chatWindowNotice => '当前没有任何消息，点击进入到消息列表';

  @override
  String get enableFileClassification => '开启文件分类';

  @override
  String get classifyTips => '注意，文件分类开启后会自动整理下载路径的所有文件';

  @override
  String get clearCache => '缓存清理';

  @override
  String get clearSuccess => '清理成功';

  @override
  String cacheSize(num number) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: '当前缓存大小${number}MB',
    );
    return '$_temp0';
  }

  @override
  String get curCacheSize => '当前缓存大小';

  @override
  String get nightmare => '梦魇兽';

  @override
  String get enableWebServer => '开启Web服务器';

  @override
  String get enableWebServerTips => '开启后，局域网设备可通过以下地址访问到本机设备的所有文件';

  @override
  String get fileType => '文件相关';

  @override
  String get select => '选择';

  @override
  String get vipTips => '这个功能需要会员才能使用哦';

  @override
  String get fileIsDownloading => '文件正在下载';

  @override
  String get fileDownloadSuccess => '下载完成了哦';

  @override
  String get open => '打开';

  @override
  String get close => '关闭';

  @override
  String get sendFile => '发送文件';

  @override
  String get camera => '拍照';

  @override
  String get device => '设备';

  @override
  String get uploadFile => '上传文件';

  @override
  String get allDevices => '全部设备';

  @override
  String get systemManager => '系统管理器';

  @override
  String get systemManagerTips => '点击将会调用系统的文件选择器';

  @override
  String get inlineManager => '内部管理器';

  @override
  String get inlineManagerTips => '点击将调用自实现的文件选择器';

  @override
  String get new_line => '换行';

  @override
  String get home => '首页';

  @override
  String get join => '加入';

  @override
  String get connected => '已连接';

  @override
  String get disconnected => '未连接';

  @override
  String get androidSAFTips =>
      '安卓SAF架构会导致从系统文件夹选择文件总是会拷贝一份，如果使用速享自带文件管理器选择，则不会增加缓存大小';

  @override
  String get fileManagerLocal => '文件管理(本地)';

  @override
  String get fileManager => '文件管理';

  @override
  String get shareFileFailed => '文件分享失败';

  @override
  String get dropFileTip => '释放以分享文件到共享窗口~';

  @override
  String get inputAddressTip => '请输入文件共享窗口地址';

  @override
  String get copyed => '链接已复制';

  @override
  String get cacheCleaned => '缓存已清理';

  @override
  String get exceptionOrcur => '发生异常';

  @override
  String get clipboardCopy => '的剪切板已复制';

  @override
  String get noIPFound => '未检测到可上传IP';

  @override
  String get backAgainTip => '再次返回退出APP~';

  @override
  String tapToViewFile(Object deviceName) {
    return '点击即可访问$deviceName的所有文件';
  }

  @override
  String get notifyBroswerTip => '已通知浏览器上传文件';

  @override
  String get clipboard => '剪切板';

  @override
  String get fileQRCode => '文件二维码';

  @override
  String get export => '导出';

  @override
  String get openQQFail => '唤起QQ失败，请检查是否安装';

  @override
  String get needWSTip => '请先去速享客户端中开启WebServer';
}
