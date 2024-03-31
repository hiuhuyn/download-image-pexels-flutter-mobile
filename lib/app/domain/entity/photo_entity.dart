import 'package:wallpaper_app/app/domain/entity/media.dart';

class PhotoEntity extends Media {
  String? src;

  PhotoEntity({
    id,
    width,
    height,
    this.src,
  });
  @override
  String toString() {
    return 'PhotoEntity{id: $id, width: $width, height: $height, src: $src}';
  }
}
