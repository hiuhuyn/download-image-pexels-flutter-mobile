import 'package:flutter/material.dart';
import 'package:wallpaper_app/presentation/pages/page_not_found.dart';

class CustomeRoute {
  static PageRoute generate(RouteSettings settings) {
    print("route: ${settings.name}");
    print("arguments: ${settings.arguments}");

    return MaterialPageRoute(
        builder: (context) => const PageNotFound(), settings: settings);
  }
}
