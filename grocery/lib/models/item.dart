import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModle {
  String id;
  String title;
  double price;
  String imgUrl;
  String description;
  String unit;
  bool inStock;
  ItemModle({
    this.id,
    this.title,
    this.price,
    this.imgUrl,
    this.description,
    this.unit,
    this.inStock,
  });
  factory ItemModle.formDocument(DocumentSnapshot doc) {
    Map data = doc.data;
    return ItemModle(
      id: doc.documentID,
      title: data['name'],
      price: data['price'].runtimeType == int
          ? data['price'].toDouble()
          : data['price'],
      imgUrl: data['image'],
      description: data['description'],
      unit: data['unit'],
      inStock: data['inStock'],
    );
  }
}
//! TODO
/* TODO

description 
image 
inStock true
name "Fresho Chicken - Curry Cut Without Skin"
price 125
unit "1kg" 



 */
