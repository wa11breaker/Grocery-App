import 'package:admin/provider/delivery_boy.dart';
import 'package:admin/screens/delivery_boy/widget/add_new_button.dart';
import 'package:admin/screens/delivery_boy/widget/delivery_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleveryBoy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<DeliveryBoyProvider>(context, listen: false)
        .fetchDeliveryBoyLIst();
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Delivery Boys',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            child: Consumer<DeliveryBoyProvider>(
              builder: (context, value, _) => Wrap(
                runSpacing: 32,
                spacing: 32,
                children: [
                  AddNewDeliveryBoy(),
                  ...value.deliveryBoy.map((e) => DeliveryTile(db: e)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
