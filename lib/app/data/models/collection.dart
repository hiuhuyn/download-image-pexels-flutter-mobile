import 'package:wallpaper_app/app/domain/entity/collection_entity.dart';

class Collection extends CollectionEntity {
  Collection({super.id, super.title, super.description, super.src});

  factory Collection.fromEntity(CollectionEntity entity) {
    return Collection(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        src: entity.src);
  }

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      src: json['src'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['src'] = src;
    return data;
  }
}
