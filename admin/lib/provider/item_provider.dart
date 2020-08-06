import 'package:admin/models/category_model.dart';
import 'package:admin/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ItemProvider extends ChangeNotifier {
  CategoryModel _category;
  CategoryModel get category => _category;

  List<ItemModel> _itemList = List();
  List<ItemModel> get itemList => _itemList;

  setSelectedCategory(CategoryModel category) {
    _category = category;
    notifyListeners();
  }

  getItems() async {
    _itemList.clear();
    var cat = await Firestore.instance
        .collection('container')
        .document('items')
        .collection('category')
        .document(_category.categoryId)
        .get();
    for (var i in cat.data['itemList']) {
      _itemList.add(ItemModel.fromDoc(i));
      notifyListeners();
    }
  }

  addNewItem({String name, description, unit, price}) {
    Firestore.instance
        .collection('container')
        .document('items')
        .collection('category')
        .document(_category.categoryId)
        .updateData({
      "itemList": FieldValue.arrayRemove([
        {'name': '1'}
      ])

      // arrayUnion([
      //   {
      //     'categoryId': _category.categoryId,
      //     'name': name,
      //     'image': '',
      //     'description': description,
      //     'price': double.parse(price),
      //     'unit': unit,
      //     'status': ''
      //   }
      // ])
    });
  }
}
