import 'package:wallpaper_app/app/domain/entity/media.dart';

class VideoEntity extends Media {
  String? image;
  int? duration;
  List<VideoFilesEntity>? videoFiles;
  List<VideoPicturesEntity>? videoPictures;

  VideoEntity(
      {super.id,
      super.width,
      super.height,
      this.image,
      this.duration,
      this.videoFiles,
      this.videoPictures});
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

class VideoPicturesEntity {
  int? id;
  String? picture;
  int? nr;

  VideoPicturesEntity({this.id, this.picture, this.nr});
}
