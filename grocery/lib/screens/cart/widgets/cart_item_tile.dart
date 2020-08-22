import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  final int index;

  const CartItemTile({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, _) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: lightGrey,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: value.cartItemList[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            value.cartItemList[index].title,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '₹ ' +
                              value.cartItemList[index].price.toString() +
                              ' / ' +
                              value.cartItemList[index].unit,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            // GestureDetector(
                            //   onTap: () => value.remove(value.cartItemList[index].id),
                            //   child: Container(
                            //     width: 40,
                            //     height: 40,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(8),
                            //       color: lightGrey,
                            //     ),
                            //     alignment: Alignment.center,
                            //     child: Icon(
                            //       Icons.delete,
                            //       color: Colors.grey[900],
                            //     ),
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () =>
                                  value.decrement(value.cartItemList[index].id),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: lightGrey,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                value.cartItemList[index].quandity.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  value.increment(value.cartItemList[index].id),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: lightGrey,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '₹ ${value.cartItemList[index].totalPrice}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 0,
            )
          ],
        ),
      ),
    );
  }
}
