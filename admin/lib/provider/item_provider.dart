import 'package:admin/models/category_model.dart';
import 'package:admin/models/item_model.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ItemProvider extends ChangeNotifier {
  CategoryModel _category;
  CategoryModel get category => _category;

  List<ItemModle> _itemList = List();
  List<ItemModle> get itemList => _itemList;

  bool loading = true;

  setSelectedCategory(CategoryModel category) {
    _category = category;
    loading = true;
    notifyListeners();
  }

  getItems() async {
    _itemList.clear();
    _itemList = await FAPI().filter(categoryId: _category.categoryId);
    loading = false;
    notifyListeners();
  }

  addNewItem({
    String name,
    description,
    unit,
    price,
    bool inStock,
    bool isFeatured,
    String image,
  }) {
    print(
      {
        'categoryId': _category.categoryId,
        'name': name,
        'image': image,
        'description': description,
        'featured': isFeatured,
        'price': double.parse(price),
        'unit': unit,
        'inStock': inStock,
      },
    );

    Firestore.instance.collection('items').add(
      {
        'categoryId': _category.categoryId,
        'name': name,
        'image': image,
        'description': description,
        'featured': isFeatured,
        'price': double.parse(price),
        'unit': unit,
        'inStock': inStock,
      },
    );
  }
}
