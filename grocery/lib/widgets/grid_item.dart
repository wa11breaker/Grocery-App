import 'package:flutter/material.dart';
import 'package:grocery/models/item.dart';
import 'package:grocery/screens/item_detailes/item_detailes.dart';

class GridItem extends StatelessWidget {
  final ItemModle item;
  const GridItem({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailes(
              item: item,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Align(child: Image.network(item.imgUrl)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(item.title, style: Theme.of(context).textTheme.bodyText2),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '₹' + item.price.toString(),
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
