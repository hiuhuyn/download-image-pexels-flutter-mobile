import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/presentation/pages/show_wallpaper/component/wallpeper_download_favorite_fullscreen.dart';

// ignore: must_be_immutable
class ShowWallpaperPage extends StatefulWidget {
  List<Media> items;
  ShowWallpaperPage({super.key, required this.items});

  @override
  State<ShowWallpaperPage> createState() => _ShowWallpaperPageState();
}

class _ShowWallpaperPageState extends State<ShowWallpaperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Spacer(),
          Expanded(flex: 8, child: _body()),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return CarouselSlider.builder(
        itemCount: widget.items.length > 10 ? 10 : widget.items.length,
        itemBuilder: (context, index, realIndex) {
          return WallpaperDownloadFavoriteFullScreen(
              media: widget.items[index]);
        },
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          viewportFraction: 0.6,
          enableInfiniteScroll: false,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
        ));
  }
}
