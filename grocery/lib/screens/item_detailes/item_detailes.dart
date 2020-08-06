import 'package:flutter/material.dart';
import 'package:grocery/models/item.dart';
import 'package:grocery/utilities/color.dart';

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
          children: <Widget>[
            Container(
              height: height / 2.5,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: Image.network(item.imgUrl),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height / 2.5,
                  ),
                  Container(
                    height: (height -
                        MediaQuery.of(context).padding.top -
                        height / 2.5),
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
                          height: 16,
                        ),
                        Spacer(),
                        SizedBox(
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
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
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
