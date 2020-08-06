import 'package:flutter/material.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/screens/filter/filter.dart';

class FilterIcon extends StatelessWidget {
  final Categorys category;
  const FilterIcon({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 12),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Filter(
              category: category,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.network(category.image),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(category.name)
          ],
        ),
      ),
    );
  }
}
