import 'package:flutter/foundation.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/services/firebase_api.dart';

class FeaturedProduct extends ChangeNotifier {
  List<Product> _featuredProduct;
  List<Product> get featuredProduct => _featuredProduct;

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
