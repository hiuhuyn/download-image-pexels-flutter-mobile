import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/presentation/pages/home/home_page.dart';
import 'package:wallpaper_app/app/presentation/pages/page_error/page_not_found.dart';
import 'package:wallpaper_app/core/routers/routes_name.dart';

class GenerateRouteApp {
  static PageRoute generate(RouteSettings settings) {
    // ignore: avoid_print
    print("route: ${settings.name}");

    if (settings.name == RoutesName.kHomePage) {
      return MaterialPageRoute(
          builder: (context) => const HomePage(), settings: settings);
    }

    return MaterialPageRoute(
        builder: (context) => const PageNotFound(), settings: settings);
  }
}
