import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/usecases/download_media_usecase.dart';

// ignore: must_be_immutable
class DownloadMeidaWidget extends StatefulWidget {
  Media media;
  Function(bool)? onSuccess;
  DownloadMeidaWidget({super.key, required this.media, this.onSuccess});

  @override
  State<DownloadMeidaWidget> createState() => _DownloadMeidaWidgetState();
}

class _DownloadMeidaWidgetState extends State<DownloadMeidaWidget> {
  double received = 0;
  double total = 0;
  double percent = 0.0;
  @override
  void initState() {
    super.initState();
    download();
  }

  void download() async {
    await DownloadMediaUsecase.call(
      media: widget.media,
      onReceiveProgress: (receivedP0, totalP1) {
        setState(() {
          percent = receivedP0 / totalP1 * 100;
          received = receivedP0 / 1024;
          total = totalP1 / 1024;
        });
      },
    ).then((value) {
      if (widget.onSuccess != null) {
        widget.onSuccess!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Download...",
        style: TextStyle(fontSize: 25, color: Colors.blue.shade700),
      ),
      actions: [
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "${percent.toStringAsFixed(0)}%",
            style: const TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${received.toStringAsFixed(0)}/${total.toStringAsFixed(0)} Kb",
          style: TextStyle(fontSize: 25, color: Colors.blue.shade700),
        ),
      ],
    );
  }
}
