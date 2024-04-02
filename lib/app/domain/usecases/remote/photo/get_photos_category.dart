import 'package:dio/dio.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetPhotosCategoryUsecase {
  RepositoryRemote repo;
  GetPhotosCategoryUsecase(this.repo);

  Future<DataState<List<CategoryEntity>>> call(
      {required List<CategoryEntity> titles}) async {
    return await repo.getPhotosCategory(titles);
  }

  Future<DataState<CategoryEntity>> callOne(
      {required CategoryEntity value}) async {
    final req = await repo.getSearchPhotos(value.title, 1, 1);
    if (req is DataSuccess) {
      final photo = req.data?.first;
      if (photo != null) {
        value.src = photo.src;
        return DataSuccess(value);
      } else {
        return DataFailed(DioException(
            requestOptions: RequestOptions(), message: "Not find image"));
      }
    } else {
      return DataFailed(req.error!);
    }
  }
}
