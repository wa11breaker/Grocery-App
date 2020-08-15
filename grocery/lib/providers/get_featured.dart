import 'package:flutter/foundation.dart';
import 'package:grocery/models/item.dart';
import 'package:grocery/services/firebase_api.dart';

class FeaturedProduct extends ChangeNotifier {
  List<ItemModle> _featuredProduct;
  List<ItemModle> get featuredProduct => _featuredProduct;

  bool _loading = true;
  bool get loading => _loading;

  void loadingFilter(bool status) {
    _loading = status;
    notifyListeners();
  }

  getFeaturedProduct() async {
    _featuredProduct = await FAPI().featuredProduct();
    loadingFilter(false);
  }
}
