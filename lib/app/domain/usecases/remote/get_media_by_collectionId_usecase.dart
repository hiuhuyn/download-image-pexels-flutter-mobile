import 'package:wallpaper_app/app/domain/entity/media.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetMediaByCollectionIdUsecase {
  RepositoryRemote repo;
  GetMediaByCollectionIdUsecase(this.repo);
  Future<DataState<List<Media>>> call(
      {required String collectionId, int page = 1, int perPage = 1}) {
    return repo.getMediaByCollectionId(collectionId, page, perPage);
  }
}
