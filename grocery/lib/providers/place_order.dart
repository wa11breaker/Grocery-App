import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/models/order.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends ChangeNotifier {
  String _orderId;
  String get orderId => _orderId;

  Future<bool> placeCodOrder(
      {BuildContext context,
      Address address,
      bool cod,
      String paymentId,
      String deliveryTime}) async {
    bool status = false;
    genetateOrderId();
    OrderModel order = OrderModel(
      orderedAt: Timestamp.now(),
      orderId: _orderId,
      totalPrice: Provider.of<Cart>(context, listen: false).subTotal,
      orderStatus: 'ORDER-PLACES',
      cod: cod,
      paymentId: paymentId ?? '',
      orderItems: Provider.of<Cart>(context, listen: false).cartItemList,
      orderAddress: address.wholeAddress(),
      userId: Provider.of<UserData>(context, listen: false).uid,
      phone: Provider.of<UserData>(context, listen: false).phoneNumber,
      name: Provider.of<UserData>(context, listen: false).accountDetailes.name,
      deliveryTime: deliveryTime,
    );

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
