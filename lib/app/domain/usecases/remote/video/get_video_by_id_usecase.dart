import 'package:wallpaper_app/app/domain/entity/video_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetVideoByIdUsecase {
  RepositoryRemote repo;
  GetVideoByIdUsecase(this.repo);

  Future<DataState<VideoEntity>> call({required String id}) async {
    return await repo.getVideoById(id);
  }
}
