import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wallpaper_app/app/data/data_sources/remote/api_pexels.dart';
import 'package:wallpaper_app/app/data/repository/repository_remote.dart';

final GetIt sl = GetIt.instance();

Future<void> initlizeDependencies() async {
  //
  sl.registerLazySingleton<Dio>(
    () => Dio(),
  );
  sl.registerLazySingleton<ApiPexels>(() => ApiPexels(dio: sl()));
  sl.registerLazySingleton<RepositoryRemoteImpl>(
    () => RepositoryRemoteImpl(api: sl()),
  );
}
