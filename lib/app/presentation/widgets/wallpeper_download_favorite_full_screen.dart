// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';

class WallpaperDownloadFavoriteFullScreen extends StatefulWidget {
  Media media;
  WallpaperDownloadFavoriteFullScreen({super.key, required this.media});

  @override
  State<WallpaperDownloadFavoriteFullScreen> createState() =>
      _WallpaperDownloadFavoriteFullScreenState();
}

class _WallpaperDownloadFavoriteFullScreenState
    extends State<WallpaperDownloadFavoriteFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
