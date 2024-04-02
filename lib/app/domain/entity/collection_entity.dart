class CollectionEntity {
  String? id;
  String? title;
  String? description;

  CollectionEntity({this.id, this.title, this.description});
  @override
  String toString() {
    return 'CollectionEntity{id: $id, title: $title, description: $description}';
  }
}
