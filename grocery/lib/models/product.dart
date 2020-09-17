import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String title;
  double price;
  String imgUrl;
  String description;
  String unit;
  bool inStock;
  Product({
    this.id,
    this.title,
    this.price,
    this.imgUrl,
    this.description,
    this.unit,
    this.inStock,
  });
  factory Product.formDocument(QueryDocumentSnapshot doc) {
    Map data = doc.data();
    return Product(
      id: doc.id,
      title: data['title'] ?? '',
      price: data['price'].runtimeType == int
          ? data['price'].toDouble()
          : data['price'],
      imgUrl: data['imgUrl'] ?? '',
      description: data['description'] ?? '',
      unit: data['unit'] ?? '',
      inStock: data['inStock'] ?? false,
    );
  }
}
