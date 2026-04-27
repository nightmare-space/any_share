// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get common => 'Common';

  @override
  String get setting => 'Settings';

  @override
  String get downlaodPath => 'Download Path';

  @override
  String get autoDownload => 'Auto Download';

  @override
  String get clipboardshare => 'Clipboard Share';

  @override
  String get messageNote => 'Vibrate When Receive Message';

  @override
  String get aboutSpeedShare => 'About Speed Share';

  @override
  String get currenVersion => 'Current Version';

  @override
  String get otherVersion => 'Download The Other Version';

  @override
  String get downloadTip => 'SpeedShare also support Windows、macOS、Linux';

  @override
  String get lang => 'Language';

  @override
  String get chatWindow => 'Chat Window';

  @override
  String get developer => 'Developer';

  @override
  String get openSource => 'Open Source';

  @override
  String get inputConnect => 'Input Connect';

  @override
  String get scan => 'Scan QR Code';

  @override
  String get log => 'Log';

  @override
  String get theTermsOfService => 'The Terms Of Service';

  @override
  String get privacyAgreement => 'Privacy Agreement';

  @override
  String get qrTips => 'Slide left or right to switch IP addresses';

  @override
  String get ui => 'UI Designer';

  @override
  String get recentFile => 'Recent File';

  @override
  String get recentImg => 'Recent Image';

  @override
  String get currentRoom => 'Chat Room';

  @override
  String get remoteAccessFile => 'Remote Access Local File';

  @override
  String get remoteAccessDes => 'Use broswer open this url can manager file.';

  @override
  String get directory => 'Directory';

  @override
  String get unknownFile => 'Unknown File';

  @override
  String get zip => 'Zip';

  @override
  String get doc => 'Document';

  @override
  String get music => 'Music';

  @override
  String get video => 'Video';

  @override
  String get image => 'Image';

  @override
  String get apk => 'Apk';

  @override
  String get appName => 'Speed Share';

  @override
  String headerNotice(num number) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: 'have $number connected',
      zero: 'No devices connect',
    );
    return '$_temp0';
  }

  @override
  String get recentConnect => 'Recent Connect';

  @override
  String get empty => 'Empty';

  @override
  String get projectBoard => 'Nightmare Series Project Board';

  @override
  String get joinQQGroup => 'Join Feedback Communication Group';

  @override
  String get changeLog => 'Change Log';

  @override
  String get about => 'About Speed Share';

  @override
  String get chatWindowNotice =>
      'Currently no messages, click to view the message list';

  @override
  String get enableFileClassification => 'Enable file classification';

  @override
  String get classifyTips =>
      'Note, after the file classification is turned on, all files in the download path will be automatically organized';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get clearSuccess => 'Clear Success';

  @override
  String cacheSize(num number) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: 'Current cache size ${number}MB',
    );
    return '$_temp0';
  }

  @override
  String get curCacheSize => 'Current Cache Size';

  @override
  String get nightmare => 'Nightmare';

  @override
  String get enableWebServer => 'Enable Web Server';

  @override
  String get enableWebServerTips =>
      'After enabling, you can access the file in the download path through the browser';

  @override
  String get fileType => 'File Correlation';

  @override
  String get select => 'Select';

  @override
  String get vipTips => 'This function requires a membership to use';

  @override
  String get fileIsDownloading => 'The file is downloading';

  @override
  String get fileDownloadSuccess => 'File download success';

  @override
  String get open => 'Open';

  @override
  String get close => 'Close';

  @override
  String get sendFile => 'Send File';

  @override
  String get camera => 'Camera';

  @override
  String get device => 'Devices';

  @override
  String get uploadFile => 'Upload File';

  @override
  String get allDevices => 'All Devices';

  @override
  String get systemManager => 'From System';

  @override
  String get systemManagerTips => 'It use system file manager';

  @override
  String get inlineManager => 'From App FileManager';

  @override
  String get inlineManagerTips => 'It use app\'s file manager';

  @override
  String get new_line => 'New Line';

  @override
  String get home => 'Home';

  @override
  String get join => 'Join';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get androidSAFTips =>
      'Android SAF architecture will cause the file selected from the system folder to always be copied. If you use the SpeedShare\'s file manager to select, it will not increase the cache size';

  @override
  String get fileManagerLocal => 'Local File Manager';

  @override
  String get fileManager => 'File Manager';

  @override
  String get shareFileFailed => 'Share File Failed';

  @override
  String get dropFileTip => 'Release to share files into the share window';

  @override
  String get inputAddressTip => 'Please input the file share window address';

  @override
  String get copyed => 'Link Copied';

  @override
  String get cacheCleaned => 'Cache Cleaned';

  @override
  String get exceptionOrcur => 'Exception Occur';

  @override
  String get clipboardCopy => 'Clipboard Copied';

  @override
  String get noIPFound => 'No IP Found';

  @override
  String get backAgainTip => 'Back again to exit the app';

  @override
  String tapToViewFile(Object deviceName) {
    return 'Tap to view all files of $deviceName';
  }

  @override
  String get notifyBroswerTip =>
      'The browser has been notified to upload the file';

  @override
  String get clipboard => 'Clipboard';

  @override
  String get fileQRCode => 'File QR Code';

  @override
  String get export => 'Export';

  @override
  String get openQQFail => 'Open QQ Fail, Please check if it is installed';

  @override
  String get needWSTip => 'Please enable WebServer in SpeedShare first';
}
