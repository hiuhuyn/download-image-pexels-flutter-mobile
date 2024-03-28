import 'package:wallpaper_app/app/domain/entity/user_entity.dart';

class User extends UserEntity {
  User({super.id, super.name, super.url});
  factory User.fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      name: entity.name,
      url: entity.url,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
