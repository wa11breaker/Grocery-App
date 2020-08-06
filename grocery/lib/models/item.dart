class ItemModle {
  String id;
  String title;
  double price;
  String imgUrl;
  String description;
  String unit;
  bool isAvilable;
  ItemModle({
    this.id,
    this.title,
    this.price,
    this.imgUrl,
    this.description,
    this.unit,
    this.isAvilable,
  });
  factory ItemModle.fromMap(Map data) {
    return ItemModle(
      id: data['id'],
      title: data['title'],
      price: data['price'],
      imgUrl: data['imgUrl'],
      description: data['description'],
      unit: data['unit'],
      isAvilable: data['isAvilable'],
    );
  }
}
