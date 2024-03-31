class VideoEntity {
  int? id;
  int? width;
  int? height;
  String? image;
  int? duration;
  List<VideoFilesEntity>? videoFiles;
  List<VideoPicturesEntity>? videoPictures;

  VideoEntity(
      {this.id,
      this.width,
      this.height,
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
