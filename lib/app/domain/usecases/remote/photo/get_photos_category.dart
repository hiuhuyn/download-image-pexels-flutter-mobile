import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetPhotosCategoryUsecase {
  RepositoryRemote repo;
  GetPhotosCategoryUsecase(this.repo);

  Future<DataState<List<CategoryEntity>>> call(
      {required List<CategoryEntity> titles}) async {
    return await repo.getPhotosCategory(titles);
  }
}
