import 'package:wallpaper_app/app/domain/entity/category_entity.dart';
import 'package:wallpaper_app/core/enum/type_file.dart';

part '_sqilite.g.dart';

abstract class SqliteApp {
  factory SqliteApp() => _SqliteApp();
  Future<List<CategoryEntity>> getCategorys();
}
