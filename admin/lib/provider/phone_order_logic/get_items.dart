import 'package:admin/models/item_model.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  List<ItemModle> _filterRestult;
  List<ItemModle> get filterResult => _filterRestult;

  bool _loadingFilterResult = true;
  bool get loadingFilterResult => _loadingFilterResult;

  getFilterResult() async {
    _filterRestult = await FAPI().filter();
    loadingFilter(false);
  }

  void loadingFilter(bool status) {
    _loadingFilterResult = status;
    notifyListeners();
  }
}
