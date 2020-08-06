import 'package:admin/provider/category_provider.dart';
import 'package:admin/screens/category/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'widgets/add_new_category.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Category',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 32,
          ),
          Consumer<CategoryProvider>(
            builder: (context, values, child) {
              return Wrap(
                children: [
                  AddNewCategory(),
                  ...values.categoryList
                      .map((e) => CategoryTile(
                            categoryModel: e,
                          ))
                      .toList(),
                ],
                runSpacing: 32,
                spacing: 32,
              );
            },
          ),
        ],
      ),
    );
  }
}
