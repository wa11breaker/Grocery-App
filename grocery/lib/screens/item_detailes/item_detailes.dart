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
                        // margin: const EdgeInsets.all(8),
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
                          child: Image.network(
                            item.imgUrl + item.id,
                            // fit: BoxFit.cover,
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
                    width: double.infinity,
                    child: value.cartItemList.indexWhere(
                                (element) => element.id == item.id) ==
                            -1
                        ? RaisedButton(
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
                          )
                        : RaisedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            elevation: 5,
                            color: primaryColor,
                            child: Text(
                              'GO TO CART',
                              style: TextStyle(color: Colors.white),
                            ),
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
