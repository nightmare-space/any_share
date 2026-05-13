import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';
import 'package:speed_share/common/device_type_extension.dart';
import 'package:speed_share/generated/l10n.dart';
import 'package:speed_share/models/models.dart';
import 'package:speed_share/modules/item/text_item.dart';
import 'broswer_file_item.dart';
import 'dir_item.dart';
import 'file_item.dart';

class MessageItemFactory {
  // TODO: Use extension
  static Widget? getMessageItem(MessageBaseInfo? info, bool sendByUser, BuildContext context) {
    final $ = context.$;
    Widget? child;
    if (info is TextMessage) {
      child = TextMessageItem(
        info: info,
        sendByUser: sendByUser,
      );
    } else if (info is FileMessage) {
      child = FileItem(
        info: info,
        sendByUser: sendByUser,
      );
    } else if (info is DirMessage) {
      child = DirMessageItem(
        info: info,
        sendByUser: sendByUser,
      );
    } else if (info is BrowserFileMessage) {
      child = BroswerFileItem(
        info: info,
        sendByUser: sendByUser,
      );
    }
    if (child == null) {
      return null;
    }
    return Builder(
      builder: (context) {
        return Align(
          alignment: sendByUser ? Alignment.centerLeft : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: $(10),
              vertical: $(8),
            ),
            child: Column(
              crossAxisAlignment: sendByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (info!.deviceName != null && info.deviceName!.isNotEmpty)
                  Row(
                    mainAxisAlignment: sendByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: info.deviceType?.deviceColor.withOpacityExact(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: $(8),
                          vertical: $(4),
                        ),
                        child: Center(
                          child: Text(
                            info.deviceName ?? '',
                            style: TextStyle(
                              fontSize: $(12),
                              color: info.deviceType?.deviceColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: $(4)),
                      if (info is ClipboardMessage)
                        Container(
                          decoration: BoxDecoration(
                            color: info.deviceType?.deviceColor.withOpacityExact(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.only(left: $(4)),
                          padding: EdgeInsets.symmetric(
                            horizontal: $(8),
                            vertical: $(4),
                          ),
                          child: Center(
                            child: Text(
                              context.l10n.clipboard,
                              style: TextStyle(fontSize: $(12), color: info.deviceType?.deviceColor),
                            ),
                          ),
                        ),
                    ],
                  ),
                SizedBox(
                  height: $(4),
                ),
                if (child != null) child,
              ],
            ),
          ),
        );
      },
    );
  }
}
