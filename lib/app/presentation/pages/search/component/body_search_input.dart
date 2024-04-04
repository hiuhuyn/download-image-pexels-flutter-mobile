import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/data/models/photo.dart';
import 'package:wallpaper_app/app/data/models/video.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_curated_photos_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_search_photos_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/video/get_popular_videos_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/video/get_search_video_usecase.dart';
import 'package:wallpaper_app/app/presentation/widgets/image_network_custom.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';
import 'package:wallpaper_app/core/state/data_state.dart';
import 'package:wallpaper_app/setup.dart';

class BodySearchInput extends StatefulWidget {
  String keywork;
  bool isPhotoPage;
  BodySearchInput({super.key, required this.keywork, this.isPhotoPage = true});

  @override
  State<BodySearchInput> createState() => _BodySearchInputState();
}

class _BodySearchInputState extends State<BodySearchInput> {
  final ScrollController scrollController = ScrollController();
  List<Media> _medias = [];
  int page = 0;
  String keywork = '';
  @override
  void initState() {
    super.initState();
    print("loading first");
    keywork = widget.keywork;
    page = 0;
    _medias = [];
    loadMore(perPage: 6);
    scrollController.addListener(() {
      if (_medias.isNotEmpty) {
        if (scrollController.position.pixels ==
            (scrollController.position.maxScrollExtent)) {
          loadMore();
        }
      }
    });
  }

  Future loadMore({int perPage = 16}) async {
    print("loading more...");
    if (widget.isPhotoPage) {
      if (keywork == "") {
        final req = await sl<GetCuratedPhotosUsecase>()
            .call(page: page++, perPage: perPage);
        if (req is DataSuccess) {
          setState(() {
            _medias.addAll(req.data!);
            page++;
          });
        }
      } else {
        final req = await sl<GetSearchPhotosUsecase>()
            .call(query: keywork, page: page++, perPage: perPage);
        if (req is DataSuccess) {
          setState(() {
            _medias.addAll(req.data!);
            page++;
          });
        } else {
          showAboutDialog(
              context: context, children: [Text(req.error!.message!)]);
          print("req search photo: ${req.error!.message}");
        }
      }
    } else {
      print("search video");
      if (keywork == "") {
        final req = await sl<GetPopularVideosUsecase>()
            .call(page: page++, perPage: perPage);
        if (req is DataSuccess) {
          setState(() {
            _medias.addAll(req.data!);
            page++;
          });
        }
      } else {
        final req = await sl<GetSearchVideosUsecase>()
            .call(query: keywork, page: page++, perPage: perPage);
        if (req is DataSuccess) {
          setState(() {
            _medias.addAll(req.data!);
            page++;
          });
        } else {
          showAboutDialog(
              context: context, children: [Text(req.error!.message!)]);
          print("req search video: ${req.error!.message}");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (keywork != widget.keywork) {
      page = 0;
      _medias = [];
      keywork = widget.keywork;
      loadMore(perPage: 8);
    }
    // return Center(
    //   child: Text("widget.keywork: ${widget.keywork}\nKeywork: $keywork"),
    // );
    return GridView.builder(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.5),
      itemCount: _medias.length,
      itemBuilder: (context, index) {
        final item = _medias[index];
        if (item is PhotoEntity) {
          return ImageNetworkCustom(
              onTap: () {
                List<Media> items = _medias.sublist(index);
                if (items.length < 15) {
                  loadMore(perPage: 15).then((value) {
                    items = _medias.sublist(index);
                    Navigator.pushNamed(
                        context, RoutesName.kListWallpaperSelect,
                        arguments: items);
                  });
                } else {
                  Navigator.pushNamed(context, RoutesName.kListWallpaperSelect,
                      arguments: items);
                }
              },
              url: Photo.fromEntity(item).srcLazy(w: 400)!);
        } else if (item is VideoEntity) {
          return ImageNetworkCustom(
            url: Video.fromEntity(item).image!,
            isUrlByVideo: true,
            onTap: () {
              List<Media> items = _medias.sublist(index);
              if (items.length < 15) {
                loadMore().then((value) {
                  items = _medias.sublist(index);
                  Navigator.pushNamed(context, RoutesName.kListWallpaperSelect,
                      arguments: items);
                });
              } else {
                Navigator.pushNamed(context, RoutesName.kListWallpaperSelect,
                    arguments: items);
              }
            },
          );
        } else {
          return const Text("Error");
        }
      },
    );
  }
}
