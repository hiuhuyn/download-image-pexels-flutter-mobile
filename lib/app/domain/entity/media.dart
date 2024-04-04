// ignore_for_file: public_member_api_docs, sort_constructors_first
class Media {
  int? id;
  int? width;
  int? height;
  String? url;
  Media({this.id, this.width, this.height, this.url});

  @override
  String toString() {
    return 'Media(id: $id, width: $width, height: $height, url: $url)';
  }
}
