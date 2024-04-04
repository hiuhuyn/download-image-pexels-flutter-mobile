import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gal/gal.dart';
import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';

class DownloadMediaUsecase {
  DownloadMediaUsecase._();
  static Future<bool> call(
      {required Media media, Function(int, int)? onReceiveProgress}) async {
    String mediaPath = Directory.systemTemp.path;
    mediaPath += extractFileName(media.url!);
    if (kDebugMode) {
      print("path: $mediaPath");
    }
    try {
      if (media is PhotoEntity) {
        mediaPath += ".jpg";
        if (media.src != null) {
          await Dio().download(media.src!, mediaPath,
              onReceiveProgress: onReceiveProgress);
          await Gal.putImage(mediaPath);
        } else {
          throw Exception("Src by image is not available");
        }
      }
      if (media is VideoEntity) {
        mediaPath += ".mp4";
        if (media.videoFiles != null && media.videoFiles!.isNotEmpty) {
          var videoFile = media.videoFiles!
              .firstWhere((element) => element.quality == 'hd');
          for (int i = 0; i < media.videoFiles!.length; i++) {
            var element = media.videoFiles!.elementAt(i);
            if (element.quality == "hd" &&
                element.width != null &&
                videoFile.width != null &&
                element.width! > videoFile.width!) {
              videoFile = element;
            }
          }
          await Dio().download(videoFile.link!, mediaPath,
              onReceiveProgress: onReceiveProgress);
          await Gal.putVideo(mediaPath);
        } else {
          throw Exception("Src by video is not available");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    return true;
  }

  static String extractFileName(String url) {
    // Tách phần path từ URL
    Uri uri = Uri.parse(url);
    String path = uri.path;

    // Tách phần tên file từ path
    List<String> parts = path.split('/');
    if (parts.last.isEmpty || parts.last == " ") {
      return parts[parts.length - 2];
    } else {
      return parts.last;
    }
  }
}
