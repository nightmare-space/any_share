// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class L10nHi extends L10n {
  L10nHi([String locale = 'hi']) : super(locale);

  @override
  String get common => 'सामान्य';

  @override
  String get setting => 'सेटिंग्स';

  @override
  String get downlaodPath => 'डाउनलोड पथ';

  @override
  String get autoDownload => 'ऑटो डाउनलोड';

  @override
  String get clipboardshare => 'क्लिपबोर्ड साझा करें';

  @override
  String get messageNote => 'संदेश मिलने पर वाइब्रेट करें';

  @override
  String get aboutSpeedShare => 'Speed Share के बारे में';

  @override
  String get currenVersion => 'वर्तमान संस्करण';

  @override
  String get otherVersion => 'अन्य संस्करण डाउनलोड करें';

  @override
  String get downloadTip =>
      'SpeedShare Windows, macOS, Linux को भी सपोर्ट करता है';

  @override
  String get lang => 'भाषा';

  @override
  String get chatWindow => 'चैट विंडो';

  @override
  String get developer => 'डेवलपर';

  @override
  String get openSource => 'ओपन सोर्स';

  @override
  String get inputConnect => 'मैन्युअली जोड़ें';

  @override
  String get scan => 'QR कोड स्कैन करें';

  @override
  String get log => 'लॉग';

  @override
  String get theTermsOfService => 'सेवा की शर्तें';

  @override
  String get privacyAgreement => 'गोपनीयता अनुबंध';

  @override
  String get qrTips => 'IP पते बदलने के लिए बाएँ या दाएँ स्वाइप करें';

  @override
  String get ui => 'UI डिज़ाइनर';

  @override
  String get recentFile => 'हाल की फाइलें';

  @override
  String get recentImg => 'हाल की तस्वीरें';

  @override
  String get currentRoom => 'चैट रूम';

  @override
  String get remoteAccessFile => 'दूरस्थ रूप से लोकल फाइल एक्सेस करें';

  @override
  String get remoteAccessDes => 'इस URL को ब्राउज़र में खोलकर फाइल मैनेज करें।';

  @override
  String get directory => 'फ़ोल्डर';

  @override
  String get unknownFile => 'अज्ञात फाइल';

  @override
  String get zip => 'Zip';

  @override
  String get doc => 'दस्तावेज़';

  @override
  String get music => 'संगीत';

  @override
  String get video => 'वीडियो';

  @override
  String get image => 'छवि';

  @override
  String get apk => 'Apk';

  @override
  String get appName => 'Speed Share';

  @override
  String headerNotice(num number) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: '$number डिवाइस कनेक्ट हैं',
      zero: 'कोई डिवाइस कनेक्ट नहीं है',
    );
    return '$_temp0';
  }

  @override
  String get recentConnect => 'हाल के कनेक्शन';

  @override
  String get empty => 'खाली';

  @override
  String get projectBoard => 'Nightmare सीरीज़ प्रोजेक्ट बोर्ड';

  @override
  String get joinQQGroup => 'फीडबैक समूह में शामिल हों';

  @override
  String get changeLog => 'बदलाव लॉग';

  @override
  String get about => 'Speed Share के बारे में';

  @override
  String get chatWindowNotice =>
      'अभी कोई संदेश नहीं, संदेश सूची देखने के लिए टैप करें';

  @override
  String get enableFileClassification => 'फाइल वर्गीकरण सक्षम करें';

  @override
  String get classifyTips =>
      'ध्यान दें, फाइल वर्गीकरण चालू होने पर डाउनलोड फ़ोल्डर की सभी फाइलें अपने आप व्यवस्थित हो जाएँगी';

  @override
  String get clearCache => 'कैश साफ़ करें';

  @override
  String get clearSuccess => 'सफलतापूर्वक साफ़ हुआ';

  @override
  String cacheSize(num number) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: 'वर्तमान कैश आकार ${number}MB',
    );
    return '$_temp0';
  }

  @override
  String get curCacheSize => 'वर्तमान कैश आकार';

  @override
  String get nightmare => 'Nightmare';

  @override
  String get enableWebServer => 'वेब सर्वर सक्षम करें';

  @override
  String get enableWebServerTips =>
      'चालू करने के बाद आप डाउनलोड फ़ोल्डर की फाइलों को ब्राउज़र से एक्सेस कर सकते हैं';

  @override
  String get fileType => 'फाइल संबंधन';

  @override
  String get select => 'चुनें';

  @override
  String get vipTips => 'इस सुविधा के लिए सदस्यता आवश्यक है';

  @override
  String get fileIsDownloading => 'फाइल डाउनलोड हो रही है';

  @override
  String get fileDownloadSuccess => 'फाइल सफलतापूर्वक डाउनलोड हुई';

  @override
  String get open => 'खोलें';

  @override
  String get close => 'बंद करें';

  @override
  String get sendFile => 'फाइल भेजें';

  @override
  String get camera => 'कैमरा';

  @override
  String get device => 'डिवाइस';

  @override
  String get uploadFile => 'फाइल अपलोड करें';

  @override
  String get allDevices => 'सभी डिवाइस';

  @override
  String get systemManager => 'सिस्टम से';

  @override
  String get systemManagerTips => 'यह सिस्टम फाइल मैनेजर का उपयोग करता है';

  @override
  String get inlineManager => 'ऐप FileManager से';

  @override
  String get inlineManagerTips => 'यह ऐप के फाइल मैनेजर का उपयोग करता है';

  @override
  String get new_line => 'नई पंक्ति';

  @override
  String get home => 'होम';

  @override
  String get join => 'जुड़ें';

  @override
  String get connected => 'कनेक्टेड';

  @override
  String get disconnected => 'डिस्कनेक्टेड';

  @override
  String get androidSAFTips =>
      'Android SAF के कारण सिस्टम फ़ोल्डर से चुनी गई फाइल हमेशा कॉपी हो जाती है। अगर आप SpeedShare के फाइल मैनेजर से चुनते हैं तो कैश नहीं बढ़ेगा';

  @override
  String get fileManagerLocal => 'लोकल फाइल मैनेजर';

  @override
  String get fileManager => 'फाइल मैनेजर';

  @override
  String get shareFileFailed => 'फाइल साझा करना विफल';

  @override
  String get dropFileTip => 'शेयर विंडो में फाइल भेजने के लिए छोड़ें';

  @override
  String get inputAddressTip => 'कृपया फाइल शेयर विंडो का पता दर्ज करें';

  @override
  String get copyed => 'लिंक कॉपी हुआ';

  @override
  String get cacheCleaned => 'कैश साफ़ हुआ';

  @override
  String get exceptionOrcur => 'अपवाद हुआ';

  @override
  String get clipboardCopy => 'क्लिपबोर्ड कॉपी हुआ';

  @override
  String get noIPFound => 'कोई IP नहीं मिला';

  @override
  String get backAgainTip => 'ऐप बंद करने के लिए फिर से बैक दबाएँ';

  @override
  String tapToViewFile(Object deviceName) {
    return '$deviceName की सभी फाइलें देखने के लिए टैप करें';
  }

  @override
  String get notifyBroswerTip =>
      'ब्राउज़र को फाइल अपलोड करने की सूचना दी गई है';

  @override
  String get clipboard => 'क्लिपबोर्ड';

  @override
  String get fileQRCode => 'फाइल QR कोड';

  @override
  String get export => 'निर्यात';

  @override
  String get openQQFail => 'QQ नहीं खुला, कृपया जाँच करें कि वह इंस्टॉल है';

  @override
  String get needWSTip => 'कृपया पहले SpeedShare में वेब सर्वर सक्षम करें';
}
