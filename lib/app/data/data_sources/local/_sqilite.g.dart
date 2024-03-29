part of 'sqlite.dart';

class _SqliteApp implements SqliteApp {
  _SqliteApp();

  @override
  Future<List<CategoryEntity>> getCategorys() async {
    return <CategoryEntity>[
      CategoryEntity(title: "Car", type: TypeFile.image),
      CategoryEntity(title: "Wallpaper", type: TypeFile.image),
      CategoryEntity(title: "Mountain", type: TypeFile.image),
      CategoryEntity(title: "Sky", type: TypeFile.image),
    ];
  }
}
