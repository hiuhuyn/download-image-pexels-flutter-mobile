import 'package:wallpaper_app/core/enum/type_file.dart';

class CategoryEntity {
  String title;
  TypeFile type;
  String? src;
  CategoryEntity({required this.title, this.src, required this.type});
}
