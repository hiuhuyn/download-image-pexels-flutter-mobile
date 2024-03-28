import 'package:dio/dio.dart';
import 'package:wallpaper_app/core/constants/api_pexels.dart';

part 'api_pexels.g.dart';

abstract class ApiPexels {
  factory ApiPexels({Dio? dio}) = _ApiPexelsImpl;

  Future<Response> getPhotoById(String id);
  Future<Response> getCuratedPhotos(int page, int perPage);
  Future<Response> getSearchPhotos(String query, int page, int perPage);
  Future<Response> getVideoById(String id);
  Future<Response> getPopularVideos(int page, int perPage);
  Future<Response> getSearchVideos(String query, int page, int perPage);
}
