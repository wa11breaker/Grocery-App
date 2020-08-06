import 'package:admin/models/item_model.dart';
import 'package:admin/provider/category_items_switch.dart';
import 'package:admin/provider/category_provider.dart';
import 'package:admin/provider/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'widgets/add_new_items.dart';
import 'widgets/items_tile.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, value, _) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Icon(Icons.arrow_back),
                    onTap: () =>
                        Provider.of<CategoryItemSwitch>(context, listen: false)
                            .update(false),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  value.category.categoryName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Wrap(
              children: [
                AddNewItems(),
                ...value.itemList
                    .map((e) => ItemsTile(
                          itemModel: e,
                        ))
                    .toList(),
              ],
              runSpacing: 32,
              spacing: 32,
            )

            // Wrap(
            //   children: [
            //     AddNewItems(),
            //     // ...car(),
            //   ],
            //   runSpacing: 32,
            //   spacing: 32,
            // )
          ],
        ),
      ),
    );
  }
}
