import 'package:admin/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categoryList = List();
  List<CategoryModel> get categoryList => _categoryList;

  bool _loadingCategory = false;
  bool get loadingCategory => _loadingCategory;

  getCategory() async {
    _loadingCategory = true;
    _categoryList.clear();
    DocumentSnapshot cat = await Firestore.instance
        .collection('container')
        .document('category')
        .get();
    for (var i in cat.data['categoryList']) {
      _categoryList.add(CategoryModel.fromDoc(i));
    }

    _loadingCategory = false;
    notifyListeners();
  }

  addNewCategory({String categoryId, categoryName, categoryImage}) {
    Firestore.instance.collection('container').document('category').updateData({
      "categoryList": FieldValue.arrayUnion([
        {
          'categoryId': categoryId,
          'categoryName': categoryName,
          'categoryImage': categoryImage,
        }
      ])
    }).then((value) {
      _categoryList.add(CategoryModel.fromDoc({
        'categoryId': categoryId,
        'categoryName': categoryName,
        'categoryImage': categoryImage,
      }));
      notifyListeners();
      Firestore.instance
          .collection('container')
          .document('items')
          .collection('category')
          .document(categoryId)
          .setData({'exists': true});
    });
  }
}
