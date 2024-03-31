class PhotoEntity {
  int? id;
  int? width;
  int? height;
  String? src;

  PhotoEntity({
    this.id,
    this.width,
    this.height,
    this.src,
  });
  @override
  String toString() {
    return 'PhotoEntity{id: $id, width: $width, height: $height, src: $src}';
  }
}
