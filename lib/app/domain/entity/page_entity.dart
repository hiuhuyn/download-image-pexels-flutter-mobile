import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';

class PageEntity {
  int? page;
  int? perPage;
  List<PhotoEntity>? photos;
  List<VideoEntity>? videos;
  int? totalResults;
  String? nextPage;
  String? prevPage;

  PageEntity(
      {this.page,
      this.perPage,
      this.photos,
      this.videos,
      this.totalResults,
      this.nextPage,
      this.prevPage});

  @override
  String toString() {
    return 'PageEntity{page: $page, perPage: $perPage, photos: $photos, totalResults: $totalResults, nextPage: $nextPage, prevPage: $prevPage}';
  }
}
