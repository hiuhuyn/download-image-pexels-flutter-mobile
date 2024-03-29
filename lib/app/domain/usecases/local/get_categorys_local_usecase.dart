import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_local.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetCategorysLocalUsecase {
  RepositoryLocal repo;
  GetCategorysLocalUsecase(this.repo);
  Future<DataState<List<CategoryEntity>>> call() async {
    return await repo.getCategorys();
  }
}
