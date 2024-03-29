import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wallpaper_app/app/data/data_sources/remote/api_pexels.dart';
import 'package:wallpaper_app/app/data/models/page.dart';
import 'package:wallpaper_app/app/data/models/photo.dart';
import 'package:wallpaper_app/app/data/models/video.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/entity/page_entity.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class RepositoryRemoteImpl implements RepositoryRemote {
  late ApiPexels? api;
  RepositoryRemoteImpl({this.api}) {
    api ??= ApiPexels();
  }

  @override
  Future<DataState<PageEntity>> getCuratedPhotos(int page, int perPage) async {
    try {
      final response = await api!.getCuratedPhotos(page, perPage);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess<PageEntity>(Page.fromJson(response.data));
      } else {
        return DataFailed<PageEntity>(DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PageEntity>> getPopularVideos(int page, int perPage) async {
    try {
      final response = await api!.getPopularVideos(page, perPage);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess<PageEntity>(Page.fromJson(response.data));
      } else {
        return DataFailed<PageEntity>(DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PhotoEntity>> getPhotoById(String id) async {
    try {
      final response = await api!.getPhotoById(id);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess<PhotoEntity>(Photo.fromJson(response.data));
      } else {
        return DataFailed<PhotoEntity>(DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PageEntity>> getSearchPhotos(
      String query, int page, int perPage) async {
    try {
      final response = await api!.getSearchPhotos(query, page, perPage);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess<PageEntity>(Page.fromJson(response.data));
      } else {
        return DataFailed<PageEntity>(DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PageEntity>> getSearchVideos(
      String query, int page, int perPage) async {
    try {
      final response = await api!.getSearchVideos(query, page, perPage);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess<PageEntity>(Page.fromJson(response.data));
      } else {
        return DataFailed<PageEntity>(DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<VideoEntity>> getVideoById(String id) async {
    try {
      final response = await api!.getVideoById(id);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess<VideoEntity>(Video.fromJson(response.data));
      } else {
        return DataFailed<VideoEntity>(DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<CategoryEntity>>> getPhotosCategory(
      List<CategoryEntity> titles) async {
    List<CategoryEntity> categories = [];
    for (var element in titles) {
      try {
        final response = await api!.getSearchPhotos(element.title, 1, 1);
        if (response.statusCode == HttpStatus.ok) {
          Page page = Page.fromJson(response.data);
          String? urlImg = page.photos!.first.src?.original;
          if (urlImg != null) {
            categories.add(CategoryEntity(
                title: element.title, src: urlImg, type: element.type));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("Lỗi getPhotosCategory: $e");
        }
      }
    }
    return DataSuccess<List<CategoryEntity>>(categories);
  }
}
