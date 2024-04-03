import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/data/models/photo.dart';
import 'package:wallpaper_app/app/data/models/video.dart';
import 'package:wallpaper_app/app/domain/entity/collection_entity.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/get_media_by_collectionId_usecase.dart';
import 'package:wallpaper_app/app/presentation/widgets/image_network_custom.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';
import 'package:wallpaper_app/core/state/data_state.dart';
import 'package:wallpaper_app/setup.dart';

// ignore: must_be_immutable
class ListWallpaperByCollectionPage extends StatefulWidget {
  CollectionEntity collection;
  ListWallpaperByCollectionPage({super.key, required this.collection});

  @override
  State<ListWallpaperByCollectionPage> createState() =>
      _ListWallpaperByCollectionPageState();
}

class _ListWallpaperByCollectionPageState
    extends State<ListWallpaperByCollectionPage> {
  final scrollController = ScrollController();
  List<Media> medias = [];
  int page = 0;
  @override
  void initState() {
    super.initState();
    loadMore();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          (scrollController.position.maxScrollExtent)) {
        loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.collection.title ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: GridView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        cacheExtent: 1000,
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
    );
  }

  Future loadMore() async {
    print("Loading more...");
    if (page < 100) {
      final response = await sl<GetMediaByCollectionIdUsecase>()
          .call(collectionId: widget.collection.id!, page: page++, perPage: 20);
      if (response is DataSuccess) {
        setState(() {
          medias.addAll(response.data!);
          print(medias.length);
          page++;
        });
      } else {
        showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(response.error!.message!),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop('OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Widget _itemImage(PhotoEntity photo, int index) {
    return Ink(
        child: ImageNetworkCustom(
      url: Photo.fromEntity(photo).src!,
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

  Widget _itemVideo(VideoEntity video, int index) {
    return Ink(
        child: ImageNetworkCustom(
      url: Video.fromEntity(video).image!,
      isUrlByVideo: true,
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
}
