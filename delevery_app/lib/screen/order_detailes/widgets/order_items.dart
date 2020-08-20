import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final item;
  ItemTile({
    this.item,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 60;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              child: CachedNetworkImage(
                imageUrl: item['image'],
                fit: BoxFit.cover,
              ),
              height: height,
              width: height,
            ),
          ),
          title: Text(
            '${item['title']}',
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Quantity: ${item['quandity']}',
              ),
              Text(
                'Price ₹${item['price']}',
              ),
              Text(
                'Total price ₹${item['quandity'] * item['price']}',
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
