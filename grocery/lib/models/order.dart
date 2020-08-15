import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery/models/cart_item.dart';

class OrderModel {
  final Timestamp orderedAt;
  final String orderId;
  final double totalPrice;
  final List<CartItem> orderItems;
  final bool cod;
  final String orderStatus;
  final String paymentId;
  final String orderAddress;
  final String userId;
  final String phone;
  final String name;
  final String deliveryTime;

  OrderModel({
    this.orderedAt,
    this.orderId,
    this.totalPrice,
    this.orderItems,
    this.orderStatus,
    this.deliveryTime,
    this.cod,
    this.paymentId,
    this.orderAddress,
    this.userId,
    this.phone,
    this.name,
  });
  Map<String, dynamic> toJson() => {
        'orderedAt': orderedAt,
        'orderId': orderId,
        'totalPrice': totalPrice,
        'orderItems': orderItems.map((e) => e.toJson()).toList(),
        'orderStatus': orderStatus,
        'cod': cod,
        'paymentId': paymentId,
        'orderAddress': orderAddress,
        'deliveryTime': deliveryTime,
        'userId': userId,
        'phone': phone,
        'name': name,
      };
}
