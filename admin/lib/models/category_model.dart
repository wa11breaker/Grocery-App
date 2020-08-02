import 'package:flutter/foundation.dart';

class CategoryModel {
  final String categoryName;
  final String categoryId;
  final String categoryImage;

  CategoryModel({
    @required this.categoryName,
    @required this.categoryId,
    @required this.categoryImage,
  })  : assert(categoryName != null),
        assert(categoryId != null),
        assert(categoryImage != null);

  factory CategoryModel.fromDoc(Map doc) {
    return CategoryModel(
      categoryId: doc['categoryId'],
      categoryName: doc['categoryName'],
      categoryImage: doc['categoryImage'],
    );
  }
}
