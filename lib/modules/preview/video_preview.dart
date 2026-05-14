import 'package:flutter/material.dart';
import 'package:better_player_plus/better_player_plus.dart';

// 预览视频的组件
// For previewing videos
class VideoPreview extends StatefulWidget {
  const VideoPreview({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  State createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: widget.url!.startsWith('http')
              ? BetterPlayer.network(
                  widget.url!,
                  betterPlayerConfiguration: const BetterPlayerConfiguration(
                    // aspectRatio: 9 / 16,
                    fullScreenByDefault: false,
                    autoPlay: true,
                    fit: BoxFit.contain,
                  ),
                )
              : BetterPlayer.file(
                  widget.url!,
                  betterPlayerConfiguration: const BetterPlayerConfiguration(
                    // aspectRatio: 9 / 16,
                    fullScreenByDefault: false,
                    autoPlay: true,
                    fit: BoxFit.contain,
                  ),
                ),
        ),
      ),
    );
  }
}
