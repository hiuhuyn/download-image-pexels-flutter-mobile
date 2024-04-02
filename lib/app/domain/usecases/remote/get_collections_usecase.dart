import 'package:wallpaper_app/app/domain/entity/collection_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetCollectionsUsecase {
  RepositoryRemote repo;
  GetCollectionsUsecase(this.repo);
  Future<DataState<List<CollectionEntity>>> call(
      {int page = 1, int perPage = 1, bool getImageFirst = false}) async {
    return await repo.getCollections(page, perPage, getImageFirst);
  }
}
