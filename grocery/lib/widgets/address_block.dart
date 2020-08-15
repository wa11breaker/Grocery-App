import 'package:flutter/material.dart';

class AddressBlock extends StatelessWidget {
  final String name, address, phone;
  final bool isDefault;

  const AddressBlock(
      {Key key, this.name, this.address, this.phone, this.isDefault})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              address,
              style: TextStyle(
                height: 1.5,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              phone,
              style: TextStyle(height: 1.4, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
