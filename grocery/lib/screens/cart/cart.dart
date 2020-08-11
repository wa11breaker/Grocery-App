import 'package:flutter/material.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/screens/cart/checkout.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
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
                            itemBuilder: (context, index) => Container(
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                value.cartItemList[index].image,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.cartItemList[index].title,
                                              maxLines: 3,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text('₹ ' +
                                                value.cartItemList[index]
                                                    .totalPrice
                                                    .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => value.remove(
                                              value.cartItemList[index].id),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: lightGrey,
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.grey[900],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () => value.decrement(
                                              value.cartItemList[index].id),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: lightGrey,
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.grey[900],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(value
                                              .cartItemList[index].quandity
                                              .toString()),
                                        ),
                                        GestureDetector(
                                          onTap: () => value.increment(
                                              value.cartItemList[index].id),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: lightGrey,
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.grey[900],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(
                                      height: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
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
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 5,
                            spreadRadius: 3,
                          ),
                        ]),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Row(
                            children: [
                              Text('Totoal Price :  '),
                              Text(
                                '₹ ' + value.subTotal.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpiPayment())),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 24,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Check Out',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
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
