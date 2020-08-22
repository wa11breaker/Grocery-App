import 'package:admin/models/deliveryboy_model.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/provider/delivery_boy.dart';

class DeliveryTile extends StatelessWidget {
  final DeliveryBoyModle db;

  const DeliveryTile({Key key, this.db}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String dbPassword;
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: primaryColor,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Delivery boy password',
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (value) => dbPassword = value,
                    onSubmitted: (value) => dbPassword = value,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Delete'),
                onPressed: () {
                  Provider.of<DeliveryBoyProvider>(context, listen: false)
                      .deleteDeliveryBoy(
                    email: db.email,
                    password: dbPassword,
                    uid: db.id,
                    context: context,
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    db.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    db.email,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    db.id,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                ],
              ),
              SizedBox(
                width: 12,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.grey,
                tooltip: 'Edit Category',
                onPressed: () => _showMyDialog(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
