import 'package:wallpaper_app/app/domain/entity/media.dart';

class PageEntity {
  int? page;
  int? perPage;
  List<Media>? medias;
  int? totalResults;
  String? nextPage;
  String? prevPage;

  PageEntity(
      {this.page,
      this.perPage,
      this.medias,
      this.totalResults,
      this.nextPage,
      this.prevPage});

  @override
  String toString() {
    return 'PageEntity{page: $page, perPage: $perPage, photos: $medias, totalResults: $totalResults, nextPage: $nextPage, prevPage: $prevPage}';
  }
}
