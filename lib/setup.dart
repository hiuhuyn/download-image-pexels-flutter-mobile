import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wallpaper_app/app/data/data_sources/local/sqlite.dart';
import 'package:wallpaper_app/app/data/data_sources/remote/api_pexels.dart';
import 'package:wallpaper_app/app/data/repository/repository_local.dart';
import 'package:wallpaper_app/app/data/repository/repository_remote.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_local.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/app/domain/usecases/local/get_categorys_local_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/get_collections_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/get_media_by_collectionId_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_curated_photos_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_photos_category.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/photo/get_search_photos_usecase.dart';
import 'package:wallpaper_app/app/domain/usecases/remote/video/get_search_video_usecase.dart';

final sl = GetIt.instance;

Future initlizeDependencies() async {
  //
  sl.registerLazySingleton<Dio>(
    () => Dio(),
  );
  sl.registerLazySingleton<ApiPexels>(() => ApiPexels(dio: sl()));
  sl.registerLazySingleton<RepositoryRemoteImpl>(
    () => RepositoryRemoteImpl(api: sl()),
  );
  sl.registerLazySingleton<RepositoryRemote>(
    () => RepositoryRemoteImpl(api: sl()),
  );

  sl.registerLazySingleton<SqliteApp>(
    () => SqliteApp(),
  );

  sl.registerLazySingleton<RepositoryLocal>(
    () => RepositoryLocalImpl(sqliteApp: sl()),
  );
  sl.registerLazySingleton<RepositoryLocalImpl>(
    () => RepositoryLocalImpl(sqliteApp: sl()),
  );

  // usecase
  sl.registerLazySingleton<GetPhotosCategoryUsecase>(
      () => GetPhotosCategoryUsecase(sl()));
  sl.registerLazySingleton<GetSearchPhotosUsecase>(
      () => GetSearchPhotosUsecase(sl()));
  sl.registerLazySingleton<GetCategorysLocalUsecase>(
      () => GetCategorysLocalUsecase(sl()));
  sl.registerLazySingleton<GetSearchVideosUsecase>(
      () => GetSearchVideosUsecase(sl()));
  sl.registerLazySingleton<GetCuratedPhotosUsecase>(
      () => GetCuratedPhotosUsecase(sl()));
  sl.registerLazySingleton<GetCollectionsUsecase>(
      () => GetCollectionsUsecase(sl()));
  sl.registerLazySingleton<GetMediaByCollectionIdUsecase>(
      () => GetMediaByCollectionIdUsecase(sl()));
}
