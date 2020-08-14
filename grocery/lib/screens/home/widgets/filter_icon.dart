import 'package:cached_network_image/cached_network_image.dart';
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.25),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image(
                  image: CachedNetworkImageProvider(
                    category.image,
                  ),
                ),
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
