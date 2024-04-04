import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/presentation/widgets/failed_widget.dart';
import 'package:wallpaper_app/app/presentation/widgets/loading_widget.dart';

// ignore: must_be_immutable
class VideoNetworkCustom extends StatefulWidget {
  VideoEntity? video;
  VideoPlayerController? controller;
  Function(VideoPlayerController value)? controllerBuild;
  VideoNetworkCustom._({this.video, this.controller, this.controllerBuild});
  factory VideoNetworkCustom.fromVideo(
      {required VideoEntity video,
      Function(VideoPlayerController value)? controllerBuild}) {
    return VideoNetworkCustom._(
      video: video,
      controllerBuild: controllerBuild,
    );
  }
  factory VideoNetworkCustom.fromController(
      {required VideoPlayerController controller}) {
    return VideoNetworkCustom._(controller: controller);
  }

  @override
  State<VideoNetworkCustom> createState() => _VideoNetworkCustomState();
}

class _VideoNetworkCustomState extends State<VideoNetworkCustom>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  String? url;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!
        ..setLooping(true)
        ..initialize().then((_) {
          setState(() {
            if (widget.controllerBuild != null) {
              widget.controllerBuild!(_controller);
            }
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
    } else if (widget.video != null) {
      for (var element in widget.video!.videoFiles!) {
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
          Uri.parse(url ?? widget.video!.videoFiles!.first.link!))
        ..setLooping(true)
        ..initialize().then((_) {
          setState(() {
            if (widget.controllerBuild != null) {
              widget.controllerBuild!(_controller);
            }
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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
