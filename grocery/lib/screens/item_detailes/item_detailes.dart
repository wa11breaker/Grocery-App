import 'package:flutter/material.dart';
import 'package:grocery/models/item.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/screens/cart/cart.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class ItemDetailes extends StatelessWidget {
  final ItemModle item;

  const ItemDetailes({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        height: height / 3,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Image.network(item.imgUrl),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: lightGrey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '₹' + item.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: primaryColor),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              item.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(height: 1.7),
                            ),
                            SizedBox(
                              height: 87,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<Cart>(
                builder: (context, value, _) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: SizedBox(
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen())),
                          child: Container(
                            height: 55,
                            width: 55,
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                ),
                                value.cartItemList.length > 0
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        value.cartItemList.indexWhere(
                                    (element) => element.id == item.id) ==
                                -1
                            ? Expanded(
                                child: GestureDetector(
                                  onTap: () => value.addToCart(item),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Buy Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: GestureDetector(
                                  onTap: () => value.addToCart(item),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Added',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
