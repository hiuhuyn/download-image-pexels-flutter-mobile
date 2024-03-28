import 'package:flutter/material.dart';

import 'package:wallpaper_app/core/routers/generate_route_app.dart';
import 'package:wallpaper_app/setup.dart';

void main() {
  initlizeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      onGenerateRoute: GenerateRouteApp.generate,
    );
  }
}
