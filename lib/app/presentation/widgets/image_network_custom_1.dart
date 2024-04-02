// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetworkCustom extends StatefulWidget {
  String url;
  void Function()? onTap;
  int w;
  bool isUseLazyLoad = false;
  EdgeInsets? margin;
  ImageNetworkCustom(
      {super.key, required this.url, this.onTap, this.margin, this.w = 600});

  @override
  State<ImageNetworkCustom> createState() => _ImageNetworkCustomState();
}

class _ImageNetworkCustomState extends State<ImageNetworkCustom>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      onTap: widget.onTap,
      child: CachedNetworkImage(
        imageUrl: widget.url,
        imageBuilder: (context, imageProvider) => Container(
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fitHeight,
            ),
          ),
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
