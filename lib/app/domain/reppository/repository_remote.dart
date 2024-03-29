import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/entity/page_entity.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

abstract class RepositoryRemote {
  Future<DataState<PhotoEntity>> getPhotoById(String id);
  Future<DataState<PageEntity>> getCuratedPhotos(int page, int perPage);
  Future<DataState<PageEntity>> getSearchPhotos(
      String query, int page, int perPage);
  Future<DataState<VideoEntity>> getVideoById(String id);
  Future<DataState<PageEntity>> getPopularVideos(int page, int perPage);
  Future<DataState<PageEntity>> getSearchVideos(
      String query, int page, int perPage);
  Future<DataState<List<CategoryEntity>>> getPhotosCategory(
      List<CategoryEntity> titles);
}
