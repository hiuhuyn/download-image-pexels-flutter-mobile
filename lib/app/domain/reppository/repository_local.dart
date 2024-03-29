import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

abstract class RepositoryLocal {
  Future<DataState<List<CategoryEntity>>> getCategorys();
}
