import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper_app/app/data/models/collection.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/presentation/pages/home/home_page.dart';
import 'package:wallpaper_app/app/presentation/pages/error/page_not_found.dart';
import 'package:wallpaper_app/app/presentation/pages/show_wallpaper/list_wallpaper_by_collection_page.dart';
import 'package:wallpaper_app/app/presentation/pages/search/search_input_page.dart';
import 'package:wallpaper_app/app/presentation/pages/search/search_page.dart';
import 'package:wallpaper_app/app/presentation/pages/show_wallpaper/component/fullscreen_wallpaper_page.dart';
import 'package:wallpaper_app/app/presentation/pages/show_wallpaper/show_wallpapers_page.dart';
import 'package:wallpaper_app/core/enum/type_file.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';

class GenerateRouteApp {
  static PageRoute generate(RouteSettings settings) {
    // ignore: avoid_print
    print("route: ${settings.name}");
    print("arguments: ${settings.arguments}");

    switch (settings.name) {
      case RoutesName.kHomePage:
        return MaterialPageRoute(
            builder: (context) => const HomePage(), settings: settings);
      case RoutesName.kListWallpaperSelect:
        List<Media> items = [];
        if (settings.arguments is List<Media>) {
          items.addAll(settings.arguments as List<Media>);
        }
        return MaterialPageRoute(
            builder: (context) => ShowWallpaperPage(
                  items: items,
                ),
            settings: settings);
      case RoutesName.kFullScreenWallpaper:
        final arguments = settings.arguments;
        try {
          if (arguments is Map<String, dynamic>) {
            if (arguments['type'] == TypeFile.image) {
              ImageProvider? imageProvider = arguments['imageProvider'];
              String url = arguments['url'];
              return MaterialPageRoute(
                  builder: (context) => FullScreenWallpaperPage.fromImage(
                        url: url,
                        image: imageProvider,
                      ),
                  settings: settings);
            } else if (arguments['type'] == TypeFile.video) {
              VideoPlayerController videoPlayerController =
                  arguments['videoPlayerController'];
              String url = arguments['url'];
              return MaterialPageRoute(
                builder: (context) => FullScreenWallpaperPage.fromVideo(
                  url: url,
                  videoPlayerController: videoPlayerController,
                ),
              );
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print("Lỗi format: $e");
          }
        }
        return MaterialPageRoute(
            builder: (context) => const PageNotFound(), settings: settings);
      case RoutesName.kSearch:
        return MaterialPageRoute(
            builder: (context) => const SearchPage(), settings: settings);
      case RoutesName.kSearchInput:
        String? arguments = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (context) => SearchInputPage(keyword: arguments),
            settings: settings);
      case RoutesName.kListWallpaperByCollection:
        final arguments = settings.arguments;
        if (arguments is Collection) {
          return MaterialPageRoute(
              builder: (context) => ListWallpaperByCollectionPage(
                    collection: arguments,
                  ),
              settings: settings);
        } else {
          return MaterialPageRoute(
              builder: (context) => const PageNotFound(), settings: settings);
        }
      default:
        return MaterialPageRoute(
            builder: (context) => const PageNotFound(), settings: settings);
    }
  }
}
