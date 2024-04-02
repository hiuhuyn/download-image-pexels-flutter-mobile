import 'package:wallpaper_app/app/domain/entity/media.dart';

class PhotoEntity extends Media {
  String? src;

  PhotoEntity({
    super.id,
    super.width,
    super.height,
    this.src,
  });

  @override
  String toString() {
    return 'PhotoEntity{id: $id, width: $width, height: $height, src: $src}';
  }
}
