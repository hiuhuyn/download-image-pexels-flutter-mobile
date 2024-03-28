import 'package:wallpaper_app/app/domain/entity/src_entity.dart';

class Src extends SrcEntity {
  Src({super.original});
  factory Src.fromEntity(SrcEntity entity) {
    return Src(
      original: entity.original,
    );
  }
  factory Src.fromJson(Map<String, dynamic> json) {
    return Src(
      original: json['original'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original'] = original;
    return data;
  }
}
