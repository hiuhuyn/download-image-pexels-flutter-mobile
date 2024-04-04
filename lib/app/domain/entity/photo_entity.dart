import 'package:wallpaper_app/app/domain/entity/media.dart';

class PhotoEntity extends Media {
  String? src;

  PhotoEntity({
    super.id,
    super.width,
    super.height,
    super.url,
    this.src,
  });

  @override
  String toString() {
    return '${super.toString()} : PhotoEntity{src: $src}';
  }
}
