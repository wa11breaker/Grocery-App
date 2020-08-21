class Categorys {
  String name;
  String id;
  String image;
  Categorys({
    this.id,
    this.name,
    this.image,
  });
  factory Categorys.fromMap(Map data) {
    return Categorys(
      id: data['categoryId'],
      name: data['categoryName'],
      image: data['categoryImage'],
    );
  }
}
