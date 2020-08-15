import 'package:flutter/material.dart';
import 'package:grocery/models/item.dart';
import 'package:grocery/services/firebase_api.dart';

class FilterProvider extends ChangeNotifier {
  List<ItemModle> _filterRestult;
  List<ItemModle> get filterResult => _filterRestult;

  bool _loadingFilterResult = true;
  bool get loadingFilterResult => _loadingFilterResult;

  getFilterResult(String filterId) async {
    _filterRestult = await FAPI().filter(categoryId: filterId);
    loadingFilter(false);
  }

  void loadingFilter(bool status) {
    _loadingFilterResult = status;
    notifyListeners();
  }
}
