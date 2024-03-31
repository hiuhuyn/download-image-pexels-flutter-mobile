// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetworkCustom extends StatefulWidget {
  String url;
  void Function()? onTap;
  ImageNetworkCustom({super.key, required this.url, this.onTap});

  @override
  State<ImageNetworkCustom> createState() => _ImageNetworkCustomState();
}

class _ImageNetworkCustomState extends State<ImageNetworkCustom>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return Container(
    //   color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
    //       Random().nextInt(255), Random().nextInt(255)),
    // );
    return InkWell(
      onTap: widget.onTap,
      child: CachedNetworkImage(
        imageUrl: "${widget.url}?auto=compress&cs=tinysrgb&w=700&lazy=load",
        imageBuilder: (context, imageProvider) => Container(
          margin: const EdgeInsets.all(8),
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
