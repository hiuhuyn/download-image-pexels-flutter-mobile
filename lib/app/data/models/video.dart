import 'package:wallpaper_app/app/domain/entity/video_entity.dart';

class Video extends VideoEntity {
  Video(
      {super.id,
      super.width,
      super.height,
      super.image,
      super.duration,
      super.videoFiles,
      super.videoPictures});

  factory Video.fromEntity(VideoEntity entity) {
    return Video(
      id: entity.id,
      width: entity.width,
      height: entity.height,
      image: entity.image,
      duration: entity.duration,
      videoFiles: entity.videoFiles,
      videoPictures: entity.videoPictures,
    );
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      width: json['width'],
      height: json['height'],

      image: json['image'],
      duration: json['duration'],
      // ignore: prefer_null_aware_operators
      videoFiles: json['video_files'] != null
          ? json['video_files']
              .map<VideoFiles>((e) => VideoFiles.fromJson(e))
              .toList()
          : null,
      // ignore: prefer_null_aware_operators
      videoPictures: json['video_pictures'] != null
          ? json['video_pictures']
              .map<VideoPictures>((e) => VideoPictures.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;

    data['image'] = image;
    data['duration'] = duration;

    if (videoFiles != null) {
      data['video_files'] =
          videoFiles!.map((v) => VideoFiles.fromEntity(v).toJson()).toList();
    }
    if (videoPictures != null) {
      data['video_pictures'] = videoPictures!
          .map((v) => VideoPictures.fromEntity(v).toJson())
          .toList();
    }
    return data;
  }
}

class VideoFiles extends VideoFilesEntity {
  VideoFiles(
      {super.id,
      super.quality,
      super.fileType,
      super.width,
      super.height,
      super.link});

  factory VideoFiles.fromEntity(VideoFilesEntity entity) {
    return VideoFiles(
      id: entity.id,
      quality: entity.quality,
      fileType: entity.fileType,
      width: entity.width,
      height: entity.height,
      link: entity.link,
    );
  }
  factory VideoFiles.fromJson(Map<String, dynamic> json) {
    return VideoFiles(
      id: json['id'],
      quality: json['quality'],
      fileType: json['file_type'],
      width: json['width'],
      height: json['height'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quality'] = quality;
    data['file_type'] = fileType;
    data['width'] = width;
    data['height'] = height;
    data['link'] = link;
    return data;
  }
}

class VideoPictures extends VideoPicturesEntity {
  VideoPictures({super.id, super.picture, super.nr});

  factory VideoPictures.fromEntity(VideoPicturesEntity entity) {
    return VideoPictures(
      id: entity.id,
      picture: entity.picture,
      nr: entity.nr,
    );
  }

  factory VideoPictures.fromJson(Map<String, dynamic> json) {
    return VideoPictures(
      id: json['id'],
      picture: json['picture'],
      nr: json['nr'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['picture'] = picture;
    data['nr'] = nr;
    return data;
  }
}
