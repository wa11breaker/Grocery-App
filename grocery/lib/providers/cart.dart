import 'package:grocery/models/cart_item.dart';

class Cart {
  List<CartItem> _cartItemList = List();
  List<CartItem> get cartItemList => _cartItemList;

  addToCart(CartItem itme) {
    if (_cartItemList.length == 0) {
      _cartItemList.add(itme);
    } else {
      for (var i in _cartItemList) {
        if (i == _cartItemList) {
          // todo
        }
      }
    }
  }
}
