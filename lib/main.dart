import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/app/presentation/pages/home/bloc/home_bloc.dart';
import 'package:wallpaper_app/core/routers/generate_route_app.dart';
import 'package:wallpaper_app/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initlizeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(
              getCategorys: sl(),
              getCuratedPhotos: sl(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Wallpaper',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: "/",
          onGenerateRoute: GenerateRouteApp.generate,
        ));
  }
}
