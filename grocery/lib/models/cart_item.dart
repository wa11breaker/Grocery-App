class CartItem {
  String id;
  String title;
  String image;
  double price;
  String unit;
  double totalPrice;
  int quandity;
  CartItem({
    this.id,
    this.title,
    this.image,
    this.price,
    this.unit,
    this.totalPrice,
    this.quandity,
  });
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'image': image,
        'price': price,
        'unit': unit,
        'quandity': quandity
      };
}
