class Categorys {
  String title;
  String id;
  String imgUrl;
  Categorys({
    this.id,
    this.title,
    this.imgUrl,
  });
  factory Categorys.fromMap(Map data) {
    return Categorys(
      id: data['id'],
      title: data['title'],
      imgUrl: data['imgUrl'],
    );
  }
}
