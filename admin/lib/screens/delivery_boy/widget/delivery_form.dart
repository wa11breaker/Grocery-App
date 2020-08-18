import 'package:admin/provider/delivery_boy.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DeliveryForm extends StatefulWidget {
  @override
  _DeliveryFormState createState() => _DeliveryFormState();
}

class _DeliveryFormState extends State<DeliveryForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _password.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 16,
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            controller: _name,
            keyboardType: TextInputType.number,
            cursorColor: primaryColor,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Name',
              hintStyle: TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            controller: _email,
            keyboardType: TextInputType.number,
            cursorColor: primaryColor,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Email',
              hintStyle: TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            controller: _password,
            keyboardType: TextInputType.number,
            cursorColor: primaryColor,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            FlatButton(
              child: Text('Add', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Provider.of<DeliveryBoyProvider>(context, listen: false)
                    .addNewDeliveryBoy(
                  context: context,
                  email: _email.text,
                  name: _name.text,
                  password: _password.text,
                );
              },
            ),
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[700]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      ],
    );
  }
}
