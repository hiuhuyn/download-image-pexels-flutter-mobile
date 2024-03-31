import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';

class Photo extends PhotoEntity {
  Photo({
    super.id,
    super.width,
    super.height,
    super.src,
  });
  factory Photo.fromEntity(PhotoEntity entity) {
    return Photo(
      id: entity.id,
      width: entity.width,
      height: entity.height,
      src: entity.src,
    );
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      src: json['src']['original'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['src'] = src;
    return data;
  }
}
