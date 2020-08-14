import 'package:flutter/material.dart';
import 'package:grocery/models/item.dart';
import 'package:grocery/screens/item_detailes/item_detailes.dart';
import 'package:grocery/utilities/color.dart';

class GridItem extends StatelessWidget {
  final ItemModle item;
  const GridItem({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.25),
                blurRadius: 8,
              )
            ],
          ),
          // color: Colors.green,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (item.isAvilable) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailes(
                      item: item,
                    ),
                  ),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Hero(
                          tag: item.imgUrl + item.id,
                          child: Image.network(
                            item.imgUrl,
                            // color: Colors.black,
                          ),
                        ),
                      ),
                      if (!item.isAvilable)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 32,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'OUT OF STOCK',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(item.title,
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '₹' + item.price.toString(),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: primaryColor,
                              fontSize: 16,
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
