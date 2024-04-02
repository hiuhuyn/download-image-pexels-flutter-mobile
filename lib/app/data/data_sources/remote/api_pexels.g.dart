part of 'api_pexels.dart';

// ignore: unused_element
class _ApiPexelsImpl implements ApiPexels {
  late Dio dio;
  _ApiPexelsImpl({Dio? dio}) {
    this.dio = dio ?? Dio();
  }
  @override
  Future<Response> getCuratedPhotos(int page, int perPage) async {
    return await dio.get(
        "$BASE_API_PEXELS/v1/curated?page=$page&per_page=$perPage",
        options: Options(headers: {"Authorization": API_KEY}));
  }

  @override
  Future<Response> getPopularVideos(int page, int perPage) async {
    return await dio.get(
        "$BASE_API_PEXELS/videos/popular?page=$page&per_page=$perPage",
        options: Options(headers: {"Authorization": API_KEY}));
  }

  @override
  Future<Response> getPhotoById(String id) async {
    return await dio.get("$BASE_API_PEXELS/v1/photos/$id",
        options: Options(headers: {"Authorization": API_KEY}));
  }

  @override
  Future<Response> getSearchPhotos(String query, int page, int perPage) async {
    return await dio.get(
        "$BASE_API_PEXELS/v1/search?query=$query&page=$page&per_page=$perPage",
        options: Options(headers: {"Authorization": API_KEY}));
  }

  @override
  Future<Response> getSearchVideos(String query, int page, int perPage) async {
    return await dio.get(
        "$BASE_API_PEXELS/videos/search?query=$query&page=$page&per_page=$perPage",
        options: Options(headers: {"Authorization": API_KEY}));
  }

  @override
  Future<Response> getVideoById(String id) async {
    return await dio.get("$BASE_API_PEXELS/videos/videos/$id",
        options: Options(headers: {"Authorization": API_KEY}));
  }

  @override
  Future<Response> getCollections(int page, int perPage) async {
    return await dio.get(
        "$BASE_API_PEXELS/v1/collections/featured?per_page=$perPage&page=$page");
  }

  @override
  Future<Response> getMediaByCollectionId(
      String id, int page, int perPage) async {
    return await dio.get(
        "$BASE_API_PEXELS/v1/collections/$id?per_page=$perPage&page=$page");
  }
}
