import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/screens/cart/cart.dart';
import 'package:grocery/utilities/color.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class ItemDetailes extends StatelessWidget {
  final Product item;

  const ItemDetailes({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.25),
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: Hero(
                          tag: item.imgUrl + item.id,
                          child: CachedNetworkImage(
                            imageUrl: item.imgUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    fontSize: 20,
                                  ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  '₹' + item.price.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: primaryColor),
                                ),
                                Text(
                                  ' / ' + item.unit,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        // color: primaryColor,
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 16,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              item.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                                height: 1.7,
                              ),
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
                    width: double.infinity,
                    child: Row(
                      children: [
                        cartButton(context, value),
                        SizedBox(
                          width: 16,
                        ),
                        value.cartItemList.indexWhere(
                                    (element) => element.id == item.id) ==
                                -1
                            ? addToCartButton(value)
                            : addRemoveProductButton(value)
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

  Expanded addRemoveProductButton(Cart value) {
    return Expanded(
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => value.decrement(value
                  .cartItemList[value.cartItemList
                      .indexWhere((element) => element.id == item.id)]
                  .id),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white12,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                value
                    .cartItemList[value.cartItemList
                        .indexWhere((element) => element.id == item.id)]
                    .quandity
                    .toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => value.increment(value
                  .cartItemList[value.cartItemList
                      .indexWhere((element) => element.id == item.id)]
                  .id),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white12,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded addToCartButton(Cart value) {
    return Expanded(
      child: SizedBox(
        height: 55,
        child: RaisedButton(
          onPressed: () => value.addToCart(item),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 5,
          color: primaryColor,
          child: Text(
            'ADD TO CART',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  GestureDetector cartButton(BuildContext context, Cart value) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartScreen(),
        ),
      ),
      child: Container(
        height: 55,
        width: 55,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: primaryColor,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                LineAwesomeIcons.shopping_cart,
                size: 30,
                color: primaryColor,
              ),
            ),
            value.cartItemList.length > 0
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.redAccent[200],
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
