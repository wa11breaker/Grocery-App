import 'dart:math';
import 'package:admin/models/new_order.dart';
import 'package:admin/provider/phone_order_logic/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends ChangeNotifier {
  String _orderId;
  String get orderId => _orderId;

  Future<bool> placeCodOrder({
    BuildContext context,
    String address,
    bool cod,
    String paymentId,
    String deliveryTime,
    String deliveryDate,
    String phoneNumber,
    String name,
  }) async {
    bool status = false;

    genetateOrderId();

    OrderModel order = OrderModel(
      orderedAt: Timestamp.now(),
      orderId: _orderId,
      totalPrice: Provider.of<Cart>(context, listen: false).subTotal,
      orderStatus: 'ORDER-PLACES',
      cod: cod,
      orderItems: Provider.of<Cart>(context, listen: false).cartItemList,
      orderAddress: address,
      userId: 'capitalsupply',
      phone: '+91' + phoneNumber,
      name: name,
      deliveryTime: deliveryTime,
      deliveryDay: deliveryDate,
      paymentId: '',
    );
    // print(order);

    await Firestore.instance
        .collection('orders')
        .add(order.toJson())
        .then((value) {
      if (value != null) {
        status = true;
      } else {
        status = false;
      }
    });
    return status;
  }

  genetateOrderId() {
    _orderId = 'CP' + (Random().nextInt(900000) + 1000000).toString();
    notifyListeners();
  }
}
