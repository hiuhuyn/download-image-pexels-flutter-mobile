class CollectionEntity {
  String? id;
  String? title;
  String? description;
  String? src;

  CollectionEntity({this.id, this.title, this.description, this.src});
  @override
  String toString() {
    return 'CollectionEntity{id: $id, title: $title, description: $description, src: $src}';
  }
}
