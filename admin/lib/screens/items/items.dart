import 'package:admin/provider/category_items_switch.dart';
import 'package:admin/provider/item_provider.dart';
import 'package:admin/screens/items/widgets/items_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/add_new_items.dart';

class Items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> car() {
      List<Widget> temp = [for (int i = 0; i < 10; i++) ItemsTile()];
      return temp;
    }

    return Consumer<ItemProvider>(
      builder: (context, value, _) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            AppBar(
              title: Text(value.category.categoryName,style: TextStyle(fontSize: 14),),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () =>
                    Provider.of<CategoryItemSwitch>(context, listen: false)
                        .update(false),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Wrap(
              children: [
                AddNewItems(),
                // ...car(),
              ],
              runSpacing: 32,
              spacing: 32,
            )
          ],
        ),
      ),
    );
  }
}
