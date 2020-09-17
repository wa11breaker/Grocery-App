import 'package:flutter/material.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/providers/place_order.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class OrderSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Provider.of<Cart>(context, listen: false).clear();
        Navigator.popUntil(
            context, ModalRoute.withName(Navigator.defaultRouteName));
      },
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/success.png'),
            SizedBox(
              height: 32,
            ),
            Text(
              'Order Completed Successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              'Order number ${Provider.of<PlaceOrder>(context, listen: false).orderId}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Thank you for shopping.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 28,
            ),
            FlatButton(
              color: primaryColor,
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Provider.of<Cart>(context, listen: false).clear();
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
          ],
        ),
      ),
    );
  }
}
