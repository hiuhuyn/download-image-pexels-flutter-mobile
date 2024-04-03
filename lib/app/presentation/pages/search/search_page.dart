import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/presentation/pages/search/bloc/search_bloc.dart';
import 'package:wallpaper_app/app/presentation/pages/search/bloc/search_state.dart';
import 'package:wallpaper_app/app/presentation/widgets/category_image.dart';
import 'package:wallpaper_app/core/enum/type_file.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';
import 'package:wallpaper_app/setup.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final List<CategoryEntity> listCategory = [
      // CategoryEntity(title: "Hình nền video", type: TypeFile.image),
      CategoryEntity(title: "Hoạt hình", type: TypeFile.image),
      CategoryEntity(title: "3D", type: TypeFile.image),
      CategoryEntity(title: "Giải trí - Game", type: TypeFile.image),
      CategoryEntity(title: "Thiên nhiên - Cảnh quan", type: TypeFile.image),
      CategoryEntity(title: "Động vật", type: TypeFile.image),
      CategoryEntity(title: "Hình nền đôi", type: TypeFile.image),
      CategoryEntity(title: "Tình yêu - Lãng mạng", type: TypeFile.image),
      CategoryEntity(title: "Thể thao", type: TypeFile.image),
      CategoryEntity(title: "Xe", type: TypeFile.image),
      CategoryEntity(title: "Đồ ăn", type: TypeFile.image),
      CategoryEntity(title: "Bầu trời", type: TypeFile.image),
    ];
    context.read<SearchBloc>().loadFirst(listCategory: listCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appbar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                  return Column(
                    children: [
                      _collection(state),
                      const SizedBox(
                        height: 10,
                      ),
                      _collectionTrending(state)
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _collection(SearchState state) {
    Widget body = const Center(
      child: CircularProgressIndicator(),
    );
    if (state is SearchErrorState &&
        (state.collections == null || state.collections!.isEmpty)) {
      body = Center(
        child: Text(
          state.error!.message!,
          textAlign: TextAlign.center,
        ),
      );
    } else if (state.collections != null && state.collections!.isNotEmpty) {
      body = ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: state.collections?.length,
        itemBuilder: (context, index) {
          return CategoryImage(
              width: 130,
              onTap: () {
                Navigator.pushNamed(context, RoutesName.kSearchInput,
                    arguments: state.collections?[index].title);
              },
              margin: const EdgeInsets.only(right: 5),
              borderRadius: BorderRadius.circular(5),
              category: CategoryEntity(
                  title: state.collections![index].title,
                  type: TypeFile.image,
                  src:
                      "${state.collections?[index].src}?auto=compress&cs=tinysrgb&w=600&lazy=load"));
        },
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Collection",
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: body)
      ],
    );
  }

  Widget _collectionTrending(SearchState state) {
    Widget body = const Center(
      child: CircularProgressIndicator(),
    );
    if (state is SearchErrorState && state.trendings == null) {
      body = Center(
        child: Text(
          state.error!.message!,
          textAlign: TextAlign.center,
        ),
      );
    } else if (state.trendings != null && state.trendings!.isNotEmpty) {
      body = Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            ...state.trendings!
                .map<Widget>((e) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            RoutesName.kListWallpaperByCollection,
                            arguments: e);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                        child: Text(
                          e.title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Trending",
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body
      ],
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
            child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.of(context).pushNamed(RoutesName.kSearchInput);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.search,
                  size: 20,
                )
              ],
            ),
          ),
        )),
      ],
    );
  }
}
