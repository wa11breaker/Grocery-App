import 'package:flutter/material.dart';
import 'package:grocery/widgets/grid_item.dart';

class PopularProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 24,
        childAspectRatio: 1 / 1.3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GridItem();
      },
    );
  }
}
