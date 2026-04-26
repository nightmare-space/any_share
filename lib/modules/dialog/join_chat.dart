import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/app/controller/controller.dart';
import 'package:speed_share/app/controller/utils/join_util.dart';
import 'package:speed_share/config/config.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/themes/app_colors.dart';

class JoinChat extends StatefulWidget {
  const JoinChat({Key? key}) : super(key: key);

  @override
  State createState() => _JoinChatState();
}

class _JoinChatState extends State<JoinChat> {
  TextEditingController controller = TextEditingController(
    text: '',
  );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular($(12)),
        child: SizedBox(
          height: $(200),
          width: $(300),
          child: Padding(
            padding: EdgeInsets.all($(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: $(4),
                ),
                Text(
                  S.current.inputAddressTip,
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: $(18),
                  ),
                ),
                SizedBox(
                  height: $(16),
                ),
                TextField(
                  controller: controller,
                  onSubmitted: (_) {
                    joinChat();
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xfff0f0f0),
                    hintText: 'HTTP://xxx:xxx',
                    hintStyle: TextStyle(
                      fontSize: $(12),
                    ),
                  ),
                ),
                SizedBox(height: $(8)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      joinChat();
                    },
                    child: Text(
                      S.current.join,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> joinChat() async {
    // todo
    if (controller.text.isEmpty) {
      showToast('URL不能为空');
      return;
    }
    String url = controller.text;
    if (!url.startsWith('http://')) {
      url = 'http://$url';
    }
    if (!url.endsWith(':${Config.chatPortRangeStart}')) {
      url = '$url:${Config.chatPortRangeStart}';
    }
    Get.back();
    Log.i('SendJoinEvent : $url');
    ChatController chatController = Get.find();
    await chatController.initLock.future;
    JoinUtil.sendJoinEvent(
      chatController.addrs,
      chatController.shelfBindPort,
      chatController.messageBindPort,
      url,
    );
  }
}
