// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';

class CategoryAndImage extends StatefulWidget {
  CategoryEntity category;
  double? width;
  double? height;
  CategoryAndImage(
      {super.key, required this.category, this.width, this.height});

  @override
  State<CategoryAndImage> createState() => _CategoryAndImageState();
}

class _CategoryAndImageState extends State<CategoryAndImage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CachedNetworkImage(
      width: widget.width,
      height: widget.height,
      imageUrl:
          "${widget.category.src!}?auto=compress&cs=tinysrgb&w=350&lazy=load",
      imageBuilder: (context, imageProvider) {
        return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            alignment: Alignment.bottomCenter,
            child: Text(
              widget.category.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ));
      },
      placeholder: (context, url) {
        return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(144, 93, 93, 93)),
            alignment: Alignment.bottomCenter,
            child: Text(
              widget.category.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
