import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/data/models/photo.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_curated_photos_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_search_photos_usecase.dart';
import 'package:wallpaper_app/app/presentation/widgets/image_network_custom_1.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';
import 'package:wallpaper_app/core/state/data_state.dart';
import 'package:wallpaper_app/setup.dart';

// ignore: must_be_immutable
class SearchInputPage extends StatefulWidget {
  String? keyword;
  SearchInputPage({super.key, this.keyword});

  @override
  State<SearchInputPage> createState() => _SearchInputPageState();
}

class _SearchInputPageState extends State<SearchInputPage> {
  late final TextEditingController _textCtrl;
  late final FocusNode _focusNode;
  final ScrollController scrollController = ScrollController();
  List<Media> _medias = [];
  int page = 0;
  Future loadMore({int perPage = 20}) async {
    if (_textCtrl.text == "") {
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
          .call(query: _textCtrl.text, page: page++, perPage: perPage);
      if (req is DataSuccess) {
        setState(() {
          _medias.addAll(req.data!);
          page++;
        });
      }
    }
  }

  Future search() async {
    page = 0;
    _medias = [];
    loadMore(perPage: 10);
  }

  @override
  void initState() {
    super.initState();
    _textCtrl = TextEditingController(text: widget.keyword ?? '');
    _focusNode = FocusNode();
    search();
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_appbar(), _body()],
        ),
      ),
    );
  }

  Widget _appbar() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: CupertinoSearchTextField(
            onSubmitted: (value) {
              search();
            },
            controller: _textCtrl,
            focusNode: _focusNode,
            placeholder: "Search",
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          ),
        )),
      ],
    );
  }

  Widget _body() {
    return Expanded(
        child: GridView.builder(
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
          return const Text("Video");
        } else {
          return const Text("Error");
        }
      },
    ));
  }
}
