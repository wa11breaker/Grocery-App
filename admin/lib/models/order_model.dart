import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String docId;
  Timestamp orderedAt;
  String orderId;
  double totalPrice;
  List<OrderItem> orderItems;
  bool cod;
  String orderStatus;
  String paymentId;
  String orderAddress;
  String userId;
  String phone;
  String name;
  String deliveryTime;

  OrderModel({
    this.docId,
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
  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return OrderModel(
      docId: doc.documentID,
      orderedAt: data['orderedAt'],
      orderId: data['orderId'],
      totalPrice: data['totalPrice'],
      orderItems: data['orderItems'].map((e) => OrderItem.toJson(e)).toList(),
      orderStatus: data['orderStatus'],
      deliveryTime: data['deliveryTime'],
      cod: data['cod'],
      paymentId: data['paymentId'],
      orderAddress: data['orderAddress'],
      userId: data['userId'],
      phone: data['phone'],
      name: data['name'],
    );
  }

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderedAt = json['orderedAt'];
    orderId = json['orderId'];
    totalPrice = json['totalPrice'];

    // orderItems = orderItems.forEach((element) =>)

    json['orderItems'].orderStatus = json['orderStatus'];
    deliveryTime = json['deliveryTime'];
    cod = json['cod'];
    paymentId = json['paymentId'];
    orderAddress = json['orderAddress'];
    userId = json['userId'];
    phone = json['phone'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() => {
        'orderedAt': orderedAt,
        'orderId': orderId,
        'totalPrice': totalPrice,
        'orderItems': orderItems.map((e) => e.fromJson()).toList(),
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

class OrderItem {
  String id;
  String title;
  String image;
  double price;
  String unit;
  double totalPrice;
  int quandity;
  OrderItem({
    this.id,
    this.title,
    this.image,
    this.price,
    this.unit,
    this.totalPrice,
    this.quandity,
  });

  OrderItem.toJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    unit = json['unit'];
    totalPrice = json['totalPrice'];
    quandity = json['quandity'];
  }
  Map<String, dynamic> fromJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'image': image,
        'price': price,
        'unit': unit,
        'quandity': quandity
      };
}
