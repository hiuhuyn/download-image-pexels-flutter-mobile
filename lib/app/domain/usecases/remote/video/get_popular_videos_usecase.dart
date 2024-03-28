import 'package:wallpaper_app/app/domain/entity/page_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetPopularVideosUsecase {
  RepositoryRemote repo;
  GetPopularVideosUsecase(this.repo);

  Future<DataState<PageEntity>> call({int page = 1, int perPage = 15}) async {
    return await repo.getPopularVideos(page, perPage);
  }
}
