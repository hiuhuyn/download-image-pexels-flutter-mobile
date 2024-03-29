import 'package:wallpaper_app/app/data/models/user.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';

class Video extends VideoEntity {
  Video(
      {super.id,
      super.width,
      super.height,
      super.url,
      super.image,
      super.duration,
      super.user,
      super.videoFiles,
      super.videoPictures});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      image: json['image'],
      duration: json['duration'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      // ignore: prefer_null_aware_operators
      videoFiles: json['video_files'] != null
          ? json['video_files'].map((e) => VideoFiles.fromJson(e)).toList()
          : null,
      // ignore: prefer_null_aware_operators
      videoPictures: json['video_pictures'] != null
          ? json['video_pictures']
              .map((e) => VideoPictures.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['image'] = image;
    data['duration'] = duration;
    if (user != null) {
      data['user'] = User.fromEntity(user!).toJson();
    }
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

class VideoFiles {
  int? id;
  String? quality;
  String? fileType;
  int? width;
  int? height;
  String? link;

  VideoFiles(
      {this.id,
      this.quality,
      this.fileType,
      this.width,
      this.height,
      this.link});

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
