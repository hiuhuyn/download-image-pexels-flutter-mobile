import 'package:wallpaper_app/app/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_remote.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class GetPhotoByIdUsecase {
  RepositoryRemote repo;
  GetPhotoByIdUsecase(this.repo);

  Future<DataState<PhotoEntity>> call({required String id}) async {
    return await repo.getPhotoById(id);
  }
}
