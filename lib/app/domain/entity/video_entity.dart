// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wallpaper_app/app/domain/entity/media.dart';

class VideoEntity extends Media {
  String? image;
  int? duration;
  List<VideoFilesEntity>? videoFiles;

  VideoEntity(
      {super.id,
      super.width,
      super.height,
      super.url,
      this.image,
      this.duration,
      this.videoFiles});

  @override
  String toString() {
    return '${super.toString()} : VideoEntity(image: $image, duration: $duration, videoFiles: $videoFiles)';
  }
}

class VideoFilesEntity {
  int? id;
  String? quality;
  String? fileType;
  int? width;
  int? height;
  String? link;

  VideoFilesEntity(
      {this.id,
      this.quality,
      this.fileType,
      this.width,
      this.height,
      this.link});
}
