import 'package:admin/screens/delivery_boy/widget/delivery_form.dart';
import 'package:flutter/material.dart';

import 'package:admin/utilities/color.dart';
import 'package:flutter/rendering.dart';

class AddNewDeliveryBoy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: DeliveryForm(),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () => _showMyDialog(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 5,
                blurRadius: 10,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Add New Delivery Boy',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
