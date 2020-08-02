import 'package:admin/models/category_model.dart';
import 'package:flutter/foundation.dart';

class ItemProvider extends ChangeNotifier {
  CategoryModel _category;
  CategoryModel get category => _category;

  setSelectedCategory(CategoryModel category) {
    _category = category;
    notifyListeners();
  }

  addNewItem({String name, description, unit, price}) {
    // todo add image and status
    print({
      'categoryId': _category.categoryId,
      'name': name,
      'image': '',
      'description': description,
      'price': price.toDouble(),
      'unit': unit,
      'status': ''
    });
  }
}
