import 'package:wallpaper_app/app/domain/entity/page_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetSearchVideosUsecase {
  RepositoryRemote repo;
  GetSearchVideosUsecase(this.repo);

  Future<DataState<PageEntity>> call(
      {required String query, int page = 1, int perPage = 15}) async {
    return await repo.getSearchVideos(query, page, perPage);
  }
}
