import 'package:wallpaper_app/app/data/data_sources/local/sqlite.dart';
import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/app/domain/reppository/repository_local.dart';
import 'package:wallpaper_app/core/state/data_state.dart';

class RepositoryLocalImpl extends RepositoryLocal {
  SqliteApp? sqliteApp;
  RepositoryLocalImpl({this.sqliteApp}) {
    sqliteApp ??= SqliteApp();
  }
  @override
  Future<DataState<List<CategoryEntity>>> getCategorys() async {
    return DataSuccess<List<CategoryEntity>>(await sqliteApp!.getCategorys());
  }
}
