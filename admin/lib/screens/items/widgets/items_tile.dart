import 'package:admin/models/item_model.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';

class ItemsTile extends StatefulWidget {
  final ItemModel itemModel;

  const ItemsTile({Key key, this.itemModel}) : super(key: key);
  @override
  _ItemsTileState createState() => _ItemsTileState();
}

class _ItemsTileState extends State<ItemsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            spreadRadius: 5,
            blurRadius: 10,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.itemModel.image),
            Text(
              widget.itemModel.name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.itemModel.price.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              widget.itemModel.unit,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.itemModel.description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
