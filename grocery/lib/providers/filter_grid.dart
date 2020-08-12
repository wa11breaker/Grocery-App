import 'package:flutter/material.dart';
import 'package:grocery/models/item.dart';

class FilterProvider extends ChangeNotifier {
  List _filterRestult;
  List get filterResult => _filterRestult;

  bool _loadingFilterResult = true;
  bool get loadingFilterResult => _loadingFilterResult;

  String _errorFilterMessage;
  String get errorMessage => _errorFilterMessage;

  void loadingFilter(bool status) {
    _loadingFilterResult = status;
    notifyListeners();
  }

  getFilterResult(String filterId) {
    Future.delayed(Duration(seconds: 1)).then((value) => loadingFilter(false));
  }

  // ignore: unused_field
  List<ItemModle> filterList = [
    ItemModle(
      id: 'fhj671',
      description:
          'Coconut is a very stable fruit. It is a mature fruit of the cocos nucifera palm. The fruit is nearly spherical to oval in shape and measure between 5-10 inches in width. Its rough external husk is light green, and turns gray as the nut grown-up. The husk is about 1-2 inches in thickness and made of tough fibers. ',
      imgUrl:
          "https://www.bigbasket.com/media/uploads/p/l/10000148_28-fresho-onion.jpg",
      isAvilable: true,
      price: 100.0,
      title: 'Fresho Coconut - Medium',
      unit: '1 pc',
    ),
    ItemModle(
      id: 'fh678j1',
      description:
          'The bright red coloured and heart shaped Red Delicious apples are crunchy, juicy and slightly sweet. Red Delicious Apples are a natural source of fibre and are fat free. They contain a wide variety of anti-oxidants and polynutrients. ',
      imgUrl:
          "https://www.bigbasket.com/media/uploads/p/l/40033824_17-fresho-apple-red-deliciouswashington-regular.jpg",
      isAvilable: true,
      price: 17.0,
      title: 'Fresho Apple',
      unit: '1 pc',
    ),
    ItemModle(
      id: 'r56ty',
      description:
          'Coconut is a very stable fruit. It is a mature fruit of the cocos nucifera palm. The fruit is nearly spherical to oval in shape and measure between 5-10 inches in width. Its rough external husk is light green, and turns gray as the nut grown-up. The husk is about 1-2 inches in thickness and made of tough fibers. ',
      imgUrl:
          "https://www.bigbasket.com/media/uploads/p/l/40033824_17-fresho-apple-red-deliciouswashington-regular.jpg",
      isAvilable: true,
      price: 10.0,
      title: 'Fresho Coconut - Medium',
      unit: '1 pc',
    ),
    ItemModle(
      id: 'fhityj1',
      description:
          'Coconut is a very stable fruit. It is a mature fruit of the cocos nucifera palm. The fruit is nearly spherical to oval in shape and measure between 5-10 inches in width. Its rough external husk is light green, and turns gray as the nut grown-up. The husk is about 1-2 inches in thickness and made of tough fibers. ',
      imgUrl:
          "https://www.bigbasket.com/media/uploads/p/l/40033824_17-fresho-apple-red-deliciouswashington-regular.jpg",
      isAvilable: true,
      price: 34.0,
      title: 'Fresho Coconut - Medium',
      unit: '1 pc',
    ),
    ItemModle(
      id: 'rtyrty',
      description:
          'Coconut is a very stable fruit. It is a mature fruit of the cocos nucifera palm. The fruit is nearly spherical to oval in shape and measure between 5-10 inches in width. Its rough external husk is light green, and turns gray as the nut grown-up. The husk is about 1-2 inches in thickness and made of tough fibers. ',
      imgUrl:
          "https://www.bigbasket.com/media/uploads/p/l/40033824_17-fresho-apple-red-deliciouswashington-regular.jpg",
      isAvilable: true,
      price: 50.0,
      title: 'Fresho Coconut - Medium',
      unit: '1 pc',
    )
  ];
}
