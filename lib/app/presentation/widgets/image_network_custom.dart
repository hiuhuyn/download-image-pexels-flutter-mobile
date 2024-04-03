// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetworkCustom extends StatefulWidget {
  String? url;
  void Function()? onTap;
  int w;
  bool isLazyLoad;
  bool isUrlByVideo;
  bool isAutoCompress;
  EdgeInsets? margin;
  ImageNetworkCustom(
      {super.key,
      this.url,
      this.onTap,
      this.margin,
      this.w = 600,
      this.isLazyLoad = true,
      this.isUrlByVideo = false,
      this.isAutoCompress = true});

  @override
  State<ImageNetworkCustom> createState() => _ImageNetworkCustomState();
}

class _ImageNetworkCustomState extends State<ImageNetworkCustom>
    with AutomaticKeepAliveClientMixin {
  String url = "";
  @override
  void initState() {
    super.initState();
    if (widget.url != null) {
      url = widget.url!;
      url += "?cs=tinysrgb&w=${widget.w}";
      if (widget.isAutoCompress) {
        url += "&auto=compress";
      }
      if (widget.isLazyLoad) {
        url += "&lazy=load";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.url == null) {
      return Container(
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text("url not found"),
      );
    }
    return InkWell(
      onTap: widget.onTap,
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fitHeight,
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(8),
          child: widget.isUrlByVideo
              ? const Icon(
                  Icons.video_library,
                  size: 30,
                  color: Colors.white,
                )
              : null,
        ),
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
