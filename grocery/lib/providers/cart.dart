import 'package:flutter/foundation.dart';
import 'package:grocery/models/cart_item.dart';
import 'package:grocery/models/product.dart';

class Cart extends ChangeNotifier {
  List<CartItem> _cartItemList = List();
  List<CartItem> get cartItemList => _cartItemList;

  double _subTotal = 0;
  double get subTotal => _subTotal;

  addToCart(Product item) {
    CartItem cartItem = CartItem(
        id: item.id,
        price: item.price,
        quandity: 1,
        title: item.title,
        totalPrice: item.price,
        unit: item.unit,
        image: item.imgUrl);
    bool isPresent = false;

    if (_cartItemList.length == 0) {
      _cartItemList.add(cartItem);
      calculateSubTotal();
      notifyListeners();
    } else {
      for (int i = 0; i < _cartItemList.length; i++) {
        if (item.id == _cartItemList[i].id) {
          isPresent = true;
        }
      }
      if (!isPresent) {
        _cartItemList.add(cartItem);
        calculateSubTotal();
        notifyListeners();
      }
      // for (CartItem i in _cartItemList) {
      //   if (i.id == item.id) {
      //     notifyListeners();
      //   }
      // }
    }
    print(_cartItemList);
  }

  increment(String id) {
    for (CartItem _i in _cartItemList) {
      if (_i.id == id) {
        _i.quandity++;
        _i.totalPrice = _i.price * _i.quandity;
        calculateSubTotal();
        notifyListeners();
      }
    }
  }

  decrement(String id) {
    for (CartItem _i in _cartItemList) {
      if (_i.id == id) {
        if (_i.quandity > 1) {
          _i.quandity--;
          _i.totalPrice = _i.price * _i.quandity;
          calculateSubTotal();
          notifyListeners();
        } else {
          remove(id);
        }
      }
    }
  }

  remove(String id) {
    for (CartItem _i in _cartItemList) {
      if (_i.id == id) {
        _cartItemList.remove(_i);
        calculateSubTotal();
        notifyListeners();
      }
    }
  }

  clear() {
    _cartItemList.clear();
    notifyListeners();
  }

  double calculateSubTotal() {
    double tempSubTotal = 0;
    for (int i = 0; i < _cartItemList.length; i++) {
      tempSubTotal += _cartItemList[i].price * _cartItemList[i].quandity;
    }
    _subTotal = tempSubTotal;
    return tempSubTotal;
  }
}
