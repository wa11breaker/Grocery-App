import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ItemsTile extends StatefulWidget {
  @override
  _ItemsTileState createState() => _ItemsTileState();
}

class _ItemsTileState extends State<ItemsTile> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: lightGrey,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
                'https://5.imimg.com/data5/RK/KV/XE/SELLER-100337308/black-sharad-seedless-grapes-500x500.jpg'),
            Text(
              'Grapes',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              'Price 100',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              'Unit 1KG',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Unit 1KG',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            /*      ToggleSwitch(
              // minWidth: 90.0,
              fontSize: 12,
              activeBgColor: Colors.green,
              minHeight: 20,
              initialLabelIndex: 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              labels: ['In Stock', 'Out Of Stock'],
              activeBgColors: [Colors.blue, Colors.pink],

              onToggle: (index) {
                print('switched to: $index');
              },
            ), */
          ],
        ),
      ),
    );
  }
}
