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
    return Consumer<DeliveryBoyProvider>(
      builder: (context, value, _) => Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Wrap(
            runSpacing: 32,
            spacing: 32,
            children: [
              AddNewDeliveryBoy(),
              ...value.deliveryBoy.map((e) => DeliveryTile(db: e)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
