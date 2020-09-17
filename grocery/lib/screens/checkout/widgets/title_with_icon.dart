import 'package:flutter/material.dart';
import 'package:grocery/utilities/color.dart';

class TitlewithIcon extends StatelessWidget {
  final IconData icon;
  final String title;

  const TitlewithIcon({Key key, this.icon, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        icon,
        color: primaryColor,
      ),
    );
  }
}
