import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  List _filterRestult;
  List get filterResult => _filterRestult;

  bool _loadingFilterResult;
  bool get loadingFilterResult => _loadingFilterResult;

  String _errorFilterMessage;
  String get errorMessage => _errorFilterMessage;

  void loadingFilter(bool status) {
    _loadingFilterResult = status;
    notifyListeners();
  }

  getFilterResult(String filterId) {
    loadingFilter(true);
    Future.delayed(Duration(seconds: 1)).then((value) => loadingFilter(false));
  }
}
