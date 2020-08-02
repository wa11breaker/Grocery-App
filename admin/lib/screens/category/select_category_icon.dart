import 'package:admin/provider/category_items_switch.dart';
import 'package:admin/screens/category/category.dart';
import 'package:admin/screens/items/items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlelctCategoryItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryItemSwitch>(
      builder: (context, value, child) {
        return value.isItems?Items():Category();
      },
    );
  }
}
