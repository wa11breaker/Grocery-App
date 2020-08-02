import 'package:flutter/foundation.dart';

class ItemModel {
  final String categoryId;
  final String name;
  final String image;
  final String description;
  final String price;
  final String unit;
  final String status;

  ItemModel({
    @required this.description,
    @required this.price,
    @required this.unit,
    @required this.status,
    @required this.name,
    @required this.categoryId,
    @required this.image,
  })  : assert(name != null),
        assert(categoryId != null),
        assert(image != null),
        assert(description != null),
        assert(price != null),
        assert(unit != null),
        assert(status != null);

  factory ItemModel.fromDoc(Map doc) {
    return ItemModel(
      categoryId: doc['categoryId'],
      name: doc['name'],
      image: doc['image'],
      description: doc['description'],
      price: doc['price'],
      status: doc['status'],
      unit: doc['unit'],
    );
  }
}
