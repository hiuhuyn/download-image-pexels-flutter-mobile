// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/data/models/photo.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_search_photos_usecase.dart';
import 'package:wallpaper_app/app/presentation/widgets/category_image.dart';
import 'package:wallpaper_app/app/presentation/widgets/image_network_custom.dart';
import 'package:wallpaper_app/core/enum/type_file.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';
import 'package:wallpaper_app/core/state/data_state.dart';
import 'package:wallpaper_app/setup.dart';

class PageBodyHome extends StatefulWidget {
  CategoryEntity category;
  PageBodyHome({super.key, required this.category});

  @override
  State<PageBodyHome> createState() => _PageBodyHomeState();
}

class _PageBodyHomeState extends State<PageBodyHome>
    with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  List<Media> medias = [];
  int page = 0;
  final perPage = 10;
  bool isLoading = false;

  double heightCategory = 200;
  double widthCategory = 400;

  Future loadMore() async {
    if (widget.category.type == TypeFile.image) {
      final request = await sl<GetSearchPhotosUsecase>()
          .call(query: widget.category.title, page: page++, perPage: perPage);
      if (request is DataSuccess) {
        setState(() {
          medias.addAll(request.data!);
        });
        page++;
      } else {
        //
      }
    } else {
      // load videos
    }
  }

  @override
  void initState() {
    super.initState();
    loadMore();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          (scrollController.position.maxScrollExtent)) {
        loadMore();
      }
      if (scrollController.position.pixels >= 200 && heightCategory >= 200) {
        setState(() {
          widthCategory = widthCategory * 0.5;
          heightCategory = heightCategory * 0.5;
        });
      } else if (scrollController.position.pixels < 200 &&
          heightCategory < 200) {
        setState(() {
          heightCategory = 200;
          widthCategory = 400;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ignore: avoid_print
    print("page: $page");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          height: heightCategory,
          width: widthCategory,
          padding: const EdgeInsets.all(8),
          child: CategoryImage(
            category: widget.category,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            cacheExtent: 1000,
            padding: const EdgeInsets.all(8),
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemCount: medias.length,
            itemBuilder: (context, index) {
              final item = medias[index];
              if (item is PhotoEntity) {
                return _itemImage(item, index);
              }
              if (item is VideoEntity) {
                return _itemVideo(item, index);
              }
              return const Spacer();
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
  Widget _itemImage(PhotoEntity photo, int index) {
    return Ink(
        child: ImageNetworkCustom(
      url: Photo.fromEntity(photo).srcLazy()!,
      onTap: () {
        List<Media> items = medias.sublist(index);
        if (items.length < 15) {
          loadMore().then((value) {
            items = medias.sublist(index);
            Navigator.pushNamed(context, RoutesName.kListWallpaperSelect,
                arguments: items);
          });
        } else {
          Navigator.pushNamed(context, RoutesName.kListWallpaperSelect,
              arguments: items);
        }
      },
    ));
  }

  Widget _itemVideo(VideoEntity vieo, int index) {
    return Ink(
      child: const Text("Video"),
    );
  }
}
