import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('hi'),
    Locale('zh')
  ];

  /// No description provided for @common.
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get common;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// No description provided for @downlaodPath.
  ///
  /// In en, this message translates to:
  /// **'Download Path'**
  String get downlaodPath;

  /// No description provided for @autoDownload.
  ///
  /// In en, this message translates to:
  /// **'Auto Download'**
  String get autoDownload;

  /// No description provided for @clipboardshare.
  ///
  /// In en, this message translates to:
  /// **'Clipboard Share'**
  String get clipboardshare;

  /// No description provided for @messageNote.
  ///
  /// In en, this message translates to:
  /// **'Vibrate When Receive Message'**
  String get messageNote;

  /// No description provided for @aboutSpeedShare.
  ///
  /// In en, this message translates to:
  /// **'About Speed Share'**
  String get aboutSpeedShare;

  /// No description provided for @currenVersion.
  ///
  /// In en, this message translates to:
  /// **'Current Version'**
  String get currenVersion;

  /// No description provided for @otherVersion.
  ///
  /// In en, this message translates to:
  /// **'Download The Other Version'**
  String get otherVersion;

  /// No description provided for @downloadTip.
  ///
  /// In en, this message translates to:
  /// **'SpeedShare also support Windows、macOS、Linux'**
  String get downloadTip;

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get lang;

  /// No description provided for @chatWindow.
  ///
  /// In en, this message translates to:
  /// **'Chat Window'**
  String get chatWindow;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @openSource.
  ///
  /// In en, this message translates to:
  /// **'Open Source'**
  String get openSource;

  /// No description provided for @inputConnect.
  ///
  /// In en, this message translates to:
  /// **'Input Connect'**
  String get inputConnect;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scan;

  /// No description provided for @log.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get log;

  /// No description provided for @theTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'The Terms Of Service'**
  String get theTermsOfService;

  /// No description provided for @privacyAgreement.
  ///
  /// In en, this message translates to:
  /// **'Privacy Agreement'**
  String get privacyAgreement;

  /// No description provided for @qrTips.
  ///
  /// In en, this message translates to:
  /// **'Slide left or right to switch IP addresses'**
  String get qrTips;

  /// No description provided for @ui.
  ///
  /// In en, this message translates to:
  /// **'UI Designer'**
  String get ui;

  /// No description provided for @recentFile.
  ///
  /// In en, this message translates to:
  /// **'Recent File'**
  String get recentFile;

  /// No description provided for @recentImg.
  ///
  /// In en, this message translates to:
  /// **'Recent Image'**
  String get recentImg;

  /// No description provided for @currentRoom.
  ///
  /// In en, this message translates to:
  /// **'Chat Room'**
  String get currentRoom;

  /// No description provided for @remoteAccessFile.
  ///
  /// In en, this message translates to:
  /// **'Remote Access Local File'**
  String get remoteAccessFile;

  /// No description provided for @remoteAccessDes.
  ///
  /// In en, this message translates to:
  /// **'Use broswer open this url can manager file.'**
  String get remoteAccessDes;

  /// No description provided for @directory.
  ///
  /// In en, this message translates to:
  /// **'Directory'**
  String get directory;

  /// No description provided for @unknownFile.
  ///
  /// In en, this message translates to:
  /// **'Unknown File'**
  String get unknownFile;

  /// No description provided for @zip.
  ///
  /// In en, this message translates to:
  /// **'Zip'**
  String get zip;

  /// No description provided for @doc.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get doc;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @apk.
  ///
  /// In en, this message translates to:
  /// **'Apk'**
  String get apk;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Speed Share'**
  String get appName;

  /// No description provided for @headerNotice.
  ///
  /// In en, this message translates to:
  /// **'{number,plural, =0{No devices connect}other{have {number} connected}}'**
  String headerNotice(num number);

  /// No description provided for @recentConnect.
  ///
  /// In en, this message translates to:
  /// **'Recent Connect'**
  String get recentConnect;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

  /// No description provided for @projectBoard.
  ///
  /// In en, this message translates to:
  /// **'Nightmare Series Project Board'**
  String get projectBoard;

  /// No description provided for @joinQQGroup.
  ///
  /// In en, this message translates to:
  /// **'Join Feedback Communication Group'**
  String get joinQQGroup;

  /// No description provided for @changeLog.
  ///
  /// In en, this message translates to:
  /// **'Change Log'**
  String get changeLog;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About Speed Share'**
  String get about;

  /// No description provided for @chatWindowNotice.
  ///
  /// In en, this message translates to:
  /// **'Currently no messages, click to view the message list'**
  String get chatWindowNotice;

  /// No description provided for @enableFileClassification.
  ///
  /// In en, this message translates to:
  /// **'Enable file classification'**
  String get enableFileClassification;

  /// No description provided for @classifyTips.
  ///
  /// In en, this message translates to:
  /// **'Note, after the file classification is turned on, all files in the download path will be automatically organized'**
  String get classifyTips;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get clearCache;

  /// No description provided for @clearSuccess.
  ///
  /// In en, this message translates to:
  /// **'Clear Success'**
  String get clearSuccess;

  /// No description provided for @cacheSize.
  ///
  /// In en, this message translates to:
  /// **'{number,plural, other{Current cache size {number}MB}}'**
  String cacheSize(num number);

  /// No description provided for @curCacheSize.
  ///
  /// In en, this message translates to:
  /// **'Current Cache Size'**
  String get curCacheSize;

  /// No description provided for @nightmare.
  ///
  /// In en, this message translates to:
  /// **'Nightmare'**
  String get nightmare;

  /// No description provided for @enableWebServer.
  ///
  /// In en, this message translates to:
  /// **'Enable Web Server'**
  String get enableWebServer;

  /// No description provided for @enableWebServerTips.
  ///
  /// In en, this message translates to:
  /// **'After enabling, you can access the file in the download path through the browser'**
  String get enableWebServerTips;

  /// No description provided for @fileType.
  ///
  /// In en, this message translates to:
  /// **'File Correlation'**
  String get fileType;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @vipTips.
  ///
  /// In en, this message translates to:
  /// **'This function requires a membership to use'**
  String get vipTips;

  /// No description provided for @fileIsDownloading.
  ///
  /// In en, this message translates to:
  /// **'The file is downloading'**
  String get fileIsDownloading;

  /// No description provided for @fileDownloadSuccess.
  ///
  /// In en, this message translates to:
  /// **'File download success'**
  String get fileDownloadSuccess;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @sendFile.
  ///
  /// In en, this message translates to:
  /// **'Send File'**
  String get sendFile;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get device;

  /// No description provided for @uploadFile.
  ///
  /// In en, this message translates to:
  /// **'Upload File'**
  String get uploadFile;

  /// No description provided for @allDevices.
  ///
  /// In en, this message translates to:
  /// **'All Devices'**
  String get allDevices;

  /// No description provided for @systemManager.
  ///
  /// In en, this message translates to:
  /// **'From System'**
  String get systemManager;

  /// No description provided for @systemManagerTips.
  ///
  /// In en, this message translates to:
  /// **'It use system file manager'**
  String get systemManagerTips;

  /// No description provided for @inlineManager.
  ///
  /// In en, this message translates to:
  /// **'From App FileManager'**
  String get inlineManager;

  /// No description provided for @inlineManagerTips.
  ///
  /// In en, this message translates to:
  /// **'It use app\'s file manager'**
  String get inlineManagerTips;

  /// No description provided for @new_line.
  ///
  /// In en, this message translates to:
  /// **'New Line'**
  String get new_line;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @androidSAFTips.
  ///
  /// In en, this message translates to:
  /// **'Android SAF architecture will cause the file selected from the system folder to always be copied. If you use the SpeedShare\'s file manager to select, it will not increase the cache size'**
  String get androidSAFTips;

  /// No description provided for @fileManagerLocal.
  ///
  /// In en, this message translates to:
  /// **'Local File Manager'**
  String get fileManagerLocal;

  /// No description provided for @fileManager.
  ///
  /// In en, this message translates to:
  /// **'File Manager'**
  String get fileManager;

  /// No description provided for @shareFileFailed.
  ///
  /// In en, this message translates to:
  /// **'Share File Failed'**
  String get shareFileFailed;

  /// No description provided for @dropFileTip.
  ///
  /// In en, this message translates to:
  /// **'Release to share files into the share window'**
  String get dropFileTip;

  /// No description provided for @inputAddressTip.
  ///
  /// In en, this message translates to:
  /// **'Please input the file share window address'**
  String get inputAddressTip;

  /// No description provided for @copyed.
  ///
  /// In en, this message translates to:
  /// **'Link Copied'**
  String get copyed;

  /// No description provided for @cacheCleaned.
  ///
  /// In en, this message translates to:
  /// **'Cache Cleaned'**
  String get cacheCleaned;

  /// No description provided for @exceptionOrcur.
  ///
  /// In en, this message translates to:
  /// **'Exception Occur'**
  String get exceptionOrcur;

  /// No description provided for @clipboardCopy.
  ///
  /// In en, this message translates to:
  /// **'Clipboard Copied'**
  String get clipboardCopy;

  /// No description provided for @noIPFound.
  ///
  /// In en, this message translates to:
  /// **'No IP Found'**
  String get noIPFound;

  /// No description provided for @backAgainTip.
  ///
  /// In en, this message translates to:
  /// **'Back again to exit the app'**
  String get backAgainTip;

  /// No description provided for @tapToViewFile.
  ///
  /// In en, this message translates to:
  /// **'Tap to view all files of {deviceName}'**
  String tapToViewFile(Object deviceName);

  /// No description provided for @notifyBroswerTip.
  ///
  /// In en, this message translates to:
  /// **'The browser has been notified to upload the file'**
  String get notifyBroswerTip;

  /// No description provided for @clipboard.
  ///
  /// In en, this message translates to:
  /// **'Clipboard'**
  String get clipboard;

  /// No description provided for @fileQRCode.
  ///
  /// In en, this message translates to:
  /// **'File QR Code'**
  String get fileQRCode;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @openQQFail.
  ///
  /// In en, this message translates to:
  /// **'Open QQ Fail, Please check if it is installed'**
  String get openQQFail;

  /// No description provided for @needWSTip.
  ///
  /// In en, this message translates to:
  /// **'Please enable WebServer in SpeedShare first'**
  String get needWSTip;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'hi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'es':
      return L10nEs();
    case 'hi':
      return L10nHi();
    case 'zh':
      return L10nZh();
  }

  throw FlutterError(
      'L10n.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
