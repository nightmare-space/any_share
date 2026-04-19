// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hi';

  static String m0(number) =>
      "${Intl.plural(number, other: 'वर्तमान कैश आकार ${number}MB')}";

  static String m1(number) =>
      "${Intl.plural(number, zero: 'कोई डिवाइस कनेक्ट नहीं है', other: '${number} डिवाइस कनेक्ट हैं')}";

  static String m2(deviceName) =>
      "${deviceName} की सभी फाइलें देखने के लिए टैप करें";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Speed Share के बारे में"),
        "aboutSpeedShare":
            MessageLookupByLibrary.simpleMessage("Speed Share के बारे में"),
        "allDevices": MessageLookupByLibrary.simpleMessage("सभी डिवाइस"),
        "androidSAFTips": MessageLookupByLibrary.simpleMessage(
            "Android SAF के कारण सिस्टम फ़ोल्डर से चुनी गई फाइल हमेशा कॉपी हो जाती है। अगर आप SpeedShare के फाइल मैनेजर से चुनते हैं तो कैश नहीं बढ़ेगा"),
        "apk": MessageLookupByLibrary.simpleMessage("Apk"),
        "appName": MessageLookupByLibrary.simpleMessage("Speed Share"),
        "autoDownload": MessageLookupByLibrary.simpleMessage("ऑटो डाउनलोड"),
        "backAgainTip": MessageLookupByLibrary.simpleMessage(
            "ऐप बंद करने के लिए फिर से बैक दबाएँ"),
        "cacheCleaned": MessageLookupByLibrary.simpleMessage("कैश साफ़ हुआ"),
        "cacheSize": m0,
        "camera": MessageLookupByLibrary.simpleMessage("कैमरा"),
        "changeLog": MessageLookupByLibrary.simpleMessage("बदलाव लॉग"),
        "chatWindow": MessageLookupByLibrary.simpleMessage("चैट विंडो"),
        "chatWindowNotice": MessageLookupByLibrary.simpleMessage(
            "अभी कोई संदेश नहीं, संदेश सूची देखने के लिए टैप करें"),
        "classifyTips": MessageLookupByLibrary.simpleMessage(
            "ध्यान दें, फाइल वर्गीकरण चालू होने पर डाउनलोड फ़ोल्डर की सभी फाइलें अपने आप व्यवस्थित हो जाएँगी"),
        "clearCache": MessageLookupByLibrary.simpleMessage("कैश साफ़ करें"),
        "clearSuccess":
            MessageLookupByLibrary.simpleMessage("सफलतापूर्वक साफ़ हुआ"),
        "clipboard": MessageLookupByLibrary.simpleMessage("क्लिपबोर्ड"),
        "clipboardCopy":
            MessageLookupByLibrary.simpleMessage("क्लिपबोर्ड कॉपी हुआ"),
        "clipboardshare":
            MessageLookupByLibrary.simpleMessage("क्लिपबोर्ड साझा करें"),
        "close": MessageLookupByLibrary.simpleMessage("बंद करें"),
        "common": MessageLookupByLibrary.simpleMessage("सामान्य"),
        "connected": MessageLookupByLibrary.simpleMessage("कनेक्टेड"),
        "copyed": MessageLookupByLibrary.simpleMessage("लिंक कॉपी हुआ"),
        "curCacheSize":
            MessageLookupByLibrary.simpleMessage("वर्तमान कैश आकार"),
        "currenVersion":
            MessageLookupByLibrary.simpleMessage("वर्तमान संस्करण"),
        "currentRoom": MessageLookupByLibrary.simpleMessage("चैट रूम"),
        "developer": MessageLookupByLibrary.simpleMessage("डेवलपर"),
        "device": MessageLookupByLibrary.simpleMessage("डिवाइस"),
        "directory": MessageLookupByLibrary.simpleMessage("फ़ोल्डर"),
        "disconnected": MessageLookupByLibrary.simpleMessage("डिस्कनेक्टेड"),
        "doc": MessageLookupByLibrary.simpleMessage("दस्तावेज़"),
        "downlaodPath": MessageLookupByLibrary.simpleMessage("डाउनलोड पथ"),
        "downloadTip": MessageLookupByLibrary.simpleMessage(
            "SpeedShare Windows, macOS, Linux को भी सपोर्ट करता है"),
        "dropFileTip": MessageLookupByLibrary.simpleMessage(
            "शेयर विंडो में फाइल भेजने के लिए छोड़ें"),
        "empty": MessageLookupByLibrary.simpleMessage("खाली"),
        "enableFileClassification":
            MessageLookupByLibrary.simpleMessage("फाइल वर्गीकरण सक्षम करें"),
        "enableWebServer":
            MessageLookupByLibrary.simpleMessage("वेब सर्वर सक्षम करें"),
        "enableWebServerTips": MessageLookupByLibrary.simpleMessage(
            "चालू करने के बाद आप डाउनलोड फ़ोल्डर की फाइलों को ब्राउज़र से एक्सेस कर सकते हैं"),
        "exceptionOrcur": MessageLookupByLibrary.simpleMessage("अपवाद हुआ"),
        "export": MessageLookupByLibrary.simpleMessage("निर्यात"),
        "fileDownloadSuccess": MessageLookupByLibrary.simpleMessage(
            "फाइल सफलतापूर्वक डाउनलोड हुई"),
        "fileIsDownloading":
            MessageLookupByLibrary.simpleMessage("फाइल डाउनलोड हो रही है"),
        "fileManager": MessageLookupByLibrary.simpleMessage("फाइल मैनेजर"),
        "fileManagerLocal":
            MessageLookupByLibrary.simpleMessage("लोकल फाइल मैनेजर"),
        "fileQRCode": MessageLookupByLibrary.simpleMessage("फाइल QR कोड"),
        "fileType": MessageLookupByLibrary.simpleMessage("फाइल संबंधन"),
        "headerNotice": m1,
        "home": MessageLookupByLibrary.simpleMessage("होम"),
        "image": MessageLookupByLibrary.simpleMessage("छवि"),
        "inlineManager":
            MessageLookupByLibrary.simpleMessage("ऐप FileManager से"),
        "inlineManagerTips": MessageLookupByLibrary.simpleMessage(
            "यह ऐप के फाइल मैनेजर का उपयोग करता है"),
        "inputAddressTip": MessageLookupByLibrary.simpleMessage(
            "कृपया फाइल शेयर विंडो का पता दर्ज करें"),
        "inputConnect": MessageLookupByLibrary.simpleMessage("मैन्युअली जोड़ें"),
        "join": MessageLookupByLibrary.simpleMessage("जुड़ें"),
        "joinQQGroup":
            MessageLookupByLibrary.simpleMessage("फीडबैक समूह में शामिल हों"),
        "lang": MessageLookupByLibrary.simpleMessage("भाषा"),
        "log": MessageLookupByLibrary.simpleMessage("लॉग"),
        "messageNote":
            MessageLookupByLibrary.simpleMessage("संदेश मिलने पर वाइब्रेट करें"),
        "music": MessageLookupByLibrary.simpleMessage("संगीत"),
        "needWSTip": MessageLookupByLibrary.simpleMessage(
            "कृपया पहले SpeedShare में वेब सर्वर सक्षम करें"),
        "new_line": MessageLookupByLibrary.simpleMessage("नई पंक्ति"),
        "nightmare": MessageLookupByLibrary.simpleMessage("Nightmare"),
        "noIPFound": MessageLookupByLibrary.simpleMessage("कोई IP नहीं मिला"),
        "notifyBroswerTip": MessageLookupByLibrary.simpleMessage(
            "ब्राउज़र को फाइल अपलोड करने की सूचना दी गई है"),
        "open": MessageLookupByLibrary.simpleMessage("खोलें"),
        "openQQFail": MessageLookupByLibrary.simpleMessage(
            "QQ नहीं खुला, कृपया जाँच करें कि वह इंस्टॉल है"),
        "openSource": MessageLookupByLibrary.simpleMessage("ओपन सोर्स"),
        "otherVersion":
            MessageLookupByLibrary.simpleMessage("अन्य संस्करण डाउनलोड करें"),
        "privacyAgreement":
            MessageLookupByLibrary.simpleMessage("गोपनीयता अनुबंध"),
        "projectBoard": MessageLookupByLibrary.simpleMessage(
            "Nightmare सीरीज़ प्रोजेक्ट बोर्ड"),
        "qrTips": MessageLookupByLibrary.simpleMessage(
            "IP पते बदलने के लिए बाएँ या दाएँ स्वाइप करें"),
        "recentConnect": MessageLookupByLibrary.simpleMessage("हाल के कनेक्शन"),
        "recentFile": MessageLookupByLibrary.simpleMessage("हाल की फाइलें"),
        "recentImg": MessageLookupByLibrary.simpleMessage("हाल की तस्वीरें"),
        "remoteAccessDes": MessageLookupByLibrary.simpleMessage(
            "इस URL को ब्राउज़र में खोलकर फाइल मैनेज करें।"),
        "remoteAccessFile": MessageLookupByLibrary.simpleMessage(
            "दूरस्थ रूप से लोकल फाइल एक्सेस करें"),
        "scan": MessageLookupByLibrary.simpleMessage("QR कोड स्कैन करें"),
        "select": MessageLookupByLibrary.simpleMessage("चुनें"),
        "sendFile": MessageLookupByLibrary.simpleMessage("फाइल भेजें"),
        "setting": MessageLookupByLibrary.simpleMessage("सेटिंग्स"),
        "shareFileFailed":
            MessageLookupByLibrary.simpleMessage("फाइल साझा करना विफल"),
        "systemManager": MessageLookupByLibrary.simpleMessage("सिस्टम से"),
        "systemManagerTips": MessageLookupByLibrary.simpleMessage(
            "यह सिस्टम फाइल मैनेजर का उपयोग करता है"),
        "tapToViewFile": m2,
        "theTermsOfService":
            MessageLookupByLibrary.simpleMessage("सेवा की शर्तें"),
        "ui": MessageLookupByLibrary.simpleMessage("UI डिज़ाइनर"),
        "unknownFile": MessageLookupByLibrary.simpleMessage("अज्ञात फाइल"),
        "uploadFile": MessageLookupByLibrary.simpleMessage("फाइल अपलोड करें"),
        "video": MessageLookupByLibrary.simpleMessage("वीडियो"),
        "vipTips": MessageLookupByLibrary.simpleMessage(
            "इस सुविधा के लिए सदस्यता आवश्यक है"),
        "zip": MessageLookupByLibrary.simpleMessage("Zip")
      };
}
