import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/models/cart_item.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/providers/user_info.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends ChangeNotifier {
  placeCodOrder(context, Address address) {
    Orders order = Orders(
      time: Timestamp.now(),
      deliveryId: (Random().nextInt(900000) + 1000000).toString(),
      address: address,
      items: Provider.of<Cart>(context, listen: false).cartItemList,
      orderId: 'CP' + (Random().nextInt(900000) + 1000000).toString(),
      status: '',
      total: Provider.of<Cart>(context, listen: false).subTotal,
      userId: Provider.of<UserData>(context, listen: false).uid,
    );
    print(order);
    // Firestore.instance.collection('orders').add({order.tojson()});
  }
}

class Orders {
  final Timestamp time;
  final String deliveryId;
  final Address address;
  final List<CartItem> items;
  final String orderId;
  final String status;
  final double total;
  final String userId;

  Orders(
      {this.time,
      this.deliveryId,
      this.address,
      this.items,
      this.orderId,
      this.status,
      this.total,
      this.userId});
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = time;
    data['deliveryId'] = deliveryId;
    data['address'] = address.toJson();
    data['items'] = items;
    data['orderId'] = orderId;
    data['status'] = status;
    data['total'] = total;
    data['userId'] = userId;

    return data;
  }

/*   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  } */
}
/* 
Datetime "2020-07-24 11:56:21.938"
deliverId "NHrHH2BrWXRxw8WMk5Lo9RSOMgF2"
deliveryboyName "rr"
locality "Reshma Bhavan,Attingal"
(string)
orderid "1DhlXewlQm6wD4Qjr2oI"
phone "7012676747"
status "Delivered"
storeid "mvPXkYvrb9IIsMJrIUUw"
total "100.0"
userId "kCwwKQYsGxasdQQ85xQOaJPzwek2"
username "Renjithbhasi"
 */
