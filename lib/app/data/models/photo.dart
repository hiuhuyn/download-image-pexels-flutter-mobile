import 'package:wallpaper_app/app/data/models/src.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';

class Photo extends PhotoEntity {
  Photo(
      {super.id,
      super.width,
      super.height,
      super.url,
      super.photographer,
      super.photographerUrl,
      super.photographerId,
      super.avgColor,
      super.src,
      super.liked,
      super.alt});
  factory Photo.fromEntity(PhotoEntity entity) {
    return Photo(
      id: entity.id,
      width: entity.width,
      height: entity.height,
      url: entity.url,
      photographer: entity.photographer,
      photographerUrl: entity.photographerUrl,
      photographerId: entity.photographerId,
      avgColor: entity.avgColor,
      src: entity.src,
      liked: entity.liked,
      alt: entity.alt,
    );
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      photographerId: json['photographer_id'],
      avgColor: json['avg_color'],
      src: json['src'] != null ? Src.fromJson(json['src']) : null,
      liked: json['liked'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['photographer'] = photographer;
    data['photographer_url'] = photographerUrl;
    data['photographer_id'] = photographerId;
    data['avg_color'] = avgColor;
    if (src != null) {
      data['src'] = Src.fromEntity(src!).toJson();
    }
    data['liked'] = liked;
    data['alt'] = alt;
    return data;
  }
}
