import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';

class Photo extends PhotoEntity {
  Photo({
    super.id,
    super.width,
    super.height,
    super.url,
    super.src,
  });
  factory Photo.fromEntity(PhotoEntity entity) {
    return Photo(
      id: entity.id,
      width: entity.width,
      height: entity.height,
      url: entity.url,
      src: entity.src,
    );
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      src: json['src']['original'],
    );
  }
  String? srcLazy(
      {int? w = 600, bool autoCompress = true, bool lazyLoad = true}) {
    if (src == null) return null;
    String srcLazy = "$src?";
    if (autoCompress) {
      srcLazy += "auto=compress";
    }
    srcLazy += "&cs=tinysrgb";
    if (w != null) {
      srcLazy += "&w=$w";
    }
    if (lazyLoad) {
      srcLazy += "&lazy=load";
    }
    return srcLazy;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['src'] = src;
    return data;
  }
}
