import 'package:admin/models/item_model.dart';
import 'package:admin/provider/phone_order_logic/cart.dart';
import 'package:admin/utilities/color.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridItem extends StatelessWidget {
  final ItemModle item;
  const GridItem({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.title, style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '₹' + item.price.toString(),
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                ),
                Text(
                  ' / ' + item.unit,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        // color: primaryColor,
                        fontSize: 14,
                      ),
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (context, value, _) => GestureDetector(
                onTap: () => value.increment(
                  value.addToCart(item),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ADD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
