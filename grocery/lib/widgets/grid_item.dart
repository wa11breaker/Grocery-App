import 'package:flutter/material.dart';
import 'package:grocery/screens/item_detailes/item_detailes.dart';
import 'package:grocery/utilities/color.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ItemDetailes())),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Text('Name of the', style: Theme.of(context).textTheme.bodyText2),
          Text(
            '₹493',
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }
}
