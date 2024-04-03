import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/presentation/widgets/failed_widget.dart';
import 'package:wallpaper_app/app/presentation/widgets/loading_widget.dart';

class VideoNetworkCustom extends StatefulWidget {
  VideoEntity video;
  VideoNetworkCustom({super.key, required this.video});

  @override
  State<VideoNetworkCustom> createState() => _VideoNetworkCustomState();
}

class _VideoNetworkCustomState extends State<VideoNetworkCustom> {
  late VideoPlayerController _controller;
  String? url;

  @override
  void initState() {
    print("intit video");
    super.initState();
    for (var element in widget.video.videoFiles!) {
      if (element.fileType == "video/mp4") {
        url = element.link!;
        if ((element.width! > 800 || element.height! > 800) &&
            (element.width! < 1200 || element.height! < 1200)) {
          url = element.link!;
          break;
        }
      }
    }
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(url ?? widget.video.videoFiles!.first.link!))
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      })
      ..addListener(() {
        if (!_controller.value.isPlaying) {
          setState(() {
            _controller.play();
          });
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return _controller.value.isInitialized
          ? FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : const LoadingWidget();
    } on Exception catch (e) {
      return FailedWidget(error: e);
    }
  }
}
