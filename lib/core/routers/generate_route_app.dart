import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/presentation/pages/home/home_page.dart';
import 'package:wallpaper_app/app/presentation/pages/error/page_not_found.dart';
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
                  builder: (context) => FullScreenWallpaperImagePage(
                        url: url,
                        image: imageProvider,
                      ),
                  settings: settings);
            }
          }
        } catch (e) {
          print("Lỗi format: $e");
        }
        return MaterialPageRoute(
            builder: (context) => const PageNotFound(), settings: settings);
      case RoutesName.kSearch:
        return MaterialPageRoute(
            builder: (context) => const SearchPage(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const PageNotFound(), settings: settings);
    }
  }
}
