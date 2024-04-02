// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';

class CategoryImage extends StatefulWidget {
  CategoryEntity category;
  double? width;
  double? height;
  int widthImagePixel;
  void Function()? onTap;
  BorderRadius? borderRadius;
  Alignment? alignment;
  double? textFontSize;
  EdgeInsets? margin;
  EdgeInsets? padding;

  BoxBorder? border;
  CategoryImage(
      {super.key,
      required this.category,
      this.width,
      this.height,
      this.textFontSize,
      this.onTap,
      this.borderRadius,
      this.border,
      this.widthImagePixel = 700,
      this.alignment = Alignment.bottomCenter,
      this.margin,
      this.padding});

  @override
  State<CategoryImage> createState() => _CategoryImageState();
}

class _CategoryImageState extends State<CategoryImage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      onTap: widget.onTap,
      child: CachedNetworkImage(
        width: widget.width,
        height: widget.height,
        imageUrl:
            "${widget.category.src!}?auto=compress&cs=tinysrgb&w=${widget.widthImagePixel}&lazy=load",
        imageBuilder: (context, imageProvider) {
          return Container(
              margin: widget.margin,
              padding: widget.padding,
              decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  border: widget.border,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
              alignment: widget.alignment,
              child: Text(
                widget.category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: widget.textFontSize),
              ));
        },
        placeholder: (context, url) {
          return Container(
              margin: widget.margin,
              padding: widget.padding,
              decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  border: widget.border,
                  color: const Color.fromARGB(144, 93, 93, 93)),
              alignment: widget.alignment,
              child: Text(
                widget.category.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: widget.textFontSize),
              ));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
