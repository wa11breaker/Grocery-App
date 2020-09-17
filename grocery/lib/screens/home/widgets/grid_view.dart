import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery/providers/get_featured.dart';
import 'package:grocery/widgets/product_cell.dart';
import 'package:provider/provider.dart';

class FeaturedProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FeaturedProduct>(
      builder: (context, model, child) => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        shrinkWrap: true,
        crossAxisCount: 4,
        itemCount: model.loading ? 6 : model.featuredProduct.length,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 24,
        crossAxisSpacing: 16,
        staggeredTileBuilder: (_) => StaggeredTile.fit(2),
        itemBuilder: (BuildContext context, int index) =>
            // if loading show product grid placeholder
            model.loading
                ? ProductPlaceHolder()
                : ProductCell(item: model.featuredProduct[index]),
      ),
    );
  }
}
