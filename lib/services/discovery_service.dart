import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:multicast/multicast.dart';
import 'package:speed_share/controllers/controllers.dart';

class DiscoveryService {
  DiscoveryService._();

  static final DiscoveryService instance = DiscoveryService._();
  late final ChatController chatController = Get.find();
  final Multicast multicast = Multicast();
  final List<String> _messages = [];

  void init() {
    multicast.addListener(receiveUdpMessage);
  }

  void startBroadcast(String data) {
    if (!_messages.contains(data)) {
      _messages.add(data);
    }
    multicast.startSendBoardcast(_messages);
  }

  void stopBroadcast() {
    multicast.stopSendBoardcast();
  }

  Future<void> receiveUdpMessage(String message, String address) async {
    // Log.w(message);
    final String id = message.split(',').first;
    final String port = message.split(',').last;
    // if(message)
    // Log.e('UniqueUtil.getDevicesId() -> ${UniqueUtil.getDevicesId()}');

    if ((await PlatformUtil.localAddress()).contains(address)) {
      return;
    }
    if (id.trim() != await UniqueUtil.getDevicesId()) {
      chatController.sendJoinEvent('http://$address:$port');
    }
  }
}
