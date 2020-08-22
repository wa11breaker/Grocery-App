import 'package:admin/provider/delivery_boy.dart';
import 'package:admin/screens/orders/accepted_order.dart';
import 'package:admin/screens/orders/assigned_order.dart';
import 'package:admin/screens/orders/delivered_order.dart';
import 'package:admin/screens/orders/newOrders.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<DeliveryBoyProvider>(context, listen: false)
        .fetchDeliveryBoyLIst();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          labelColor: primaryColor,
          physics: NeverScrollableScrollPhysics(),
          tabs: [
            Tab(text: 'New Orders'),
            Tab(text: 'Accepted Orders'),
            Tab(text: 'Assigned Orders'),
            Tab(text: 'Delivered Orders'),
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            NewOrders(),
            Accepted(),
            Assigned(),
            Delivered(),
          ],
        ),
      ),
    );
  }
}
