import 'package:wallpaper_app/app/domain/entity/page_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetMediaByCollectionIdUsecase {
  RepositoryRemote repo;
  GetMediaByCollectionIdUsecase(this.repo);
  Future<DataState<PageEntity>> call(
      {required String collectionId, int page = 1, int perPage = 1}) {
    return repo.getMediaByCollectionId(collectionId, page, perPage);
  }
}
