import 'package:wallpaper_app/app/data/models/photo.dart';
import 'package:wallpaper_app/app/data/models/video.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/entity/page_entity.dart';

class Page extends PageEntity {
  Page(
      {super.page,
      super.perPage,
      super.medias,
      super.totalResults,
      super.nextPage,
      super.prevPage});

  factory Page.fromEntity(PageEntity entity) {
    return Page(
        page: entity.page,
        perPage: entity.perPage,
        medias: entity.medias,
        totalResults: entity.totalResults,
        nextPage: entity.nextPage,
        prevPage: entity.prevPage);
  }
  factory Page.fromJson(Map<String, dynamic> json) {
    List<Media> medias = [];
    if (json['photos'] != null) {
      json['photos'].forEach((photo) {
        medias.add(Photo.fromJson(photo));
      });
    }
    if (json['videos'] != null) {
      json['videos'].forEach((video) {
        medias.add(Video.fromJson(video));
      });
    }
    return Page(
      page: json['page'],
      perPage: json['per_page'],
      medias: medias,
      totalResults: json['total_results'],
      nextPage: json['next_page'],
      prevPage: json['prev_page'],
    );
  }
}
