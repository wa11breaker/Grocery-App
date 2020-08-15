import 'package:flutter/material.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/screens/cart/checkout.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

import 'widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: lightGrey,
      body: Consumer<Cart>(
        builder: (context, value, _) => SafeArea(
          child: value.cartItemList.length == 0 || value.cartItemList == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset(
                          'assets/empty_cart.png',
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text('Your cart is empty')
                    ],
                  ),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 16,
                          // ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: value.cartItemList.length,
                              itemBuilder: (context, index) => CartItemTile(
                                    index: index,
                                  )
                              // cartTile(value, index),
                              ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 5,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Row(
                            children: [
                              RaisedButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpiPayment(),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24,
                                ),
                                elevation: 5,
                                color: primaryColor,
                                child: Text(
                                  'Check Out',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Spacer(),
                              Text('Totoal Price :  '),
                              Text(
                                '₹ ' + value.subTotal.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
