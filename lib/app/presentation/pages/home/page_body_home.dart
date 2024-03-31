// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_search_photos_usecase.dart';
import 'package:wallpaper_app/app/presentation/widgets/category_image.dart';
import 'package:wallpaper_app/app/presentation/widgets/image_network_custom_1.dart';
import 'package:wallpaper_app/core/enum/type_file.dart';
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
  List<PhotoEntity> photos = [];
  List<VideoEntity> videos = [];
  int page = 0;
  final perPage = 10;
  bool isLoading = false;

  double heightCategory = 200;
  double widthCategory = 400;

  void loadMore() async {
    if (widget.category.type == TypeFile.image) {
      final request = await sl<GetSearchPhotosUsecase>()
          .call(query: widget.category.title, page: page++, perPage: perPage);
      if (request is DataSuccess) {
        setState(() {
          photos.addAll(request.data!.photos!);
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
          duration: const Duration(milliseconds: 300),
          height: heightCategory,
          width: widthCategory,
          child: CategoryAndImage(
            category: widget.category,
          ),
        ),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            cacheExtent: 1000,
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.5),
            itemCount: widget.category.type == TypeFile.image
                ? photos.length
                : videos.length,
            itemBuilder: (context, index) {
              if (widget.category.type == TypeFile.image) {
                return Ink(
                    child: ImageNetworkCustom(
                  url: photos[index].src!,
                  onTap: () {},
                ));
              } else {
                return Ink(
                  child: const Text("Video"),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
