import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/providers/filter_grid.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/product_cell.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  final Categorys category;

  const Filter({Key key, this.category}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  void initState() {
    super.initState();
    Provider.of<FilterProvider>(context, listen: false)
        .getFilterResult(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Provider.of<FilterProvider>(context, listen: false).clearFliter();
          },
        ),
        title: Text(
          widget.category.title,
          style: TextStyle(color: grey),
        ),
      ),
      body: Consumer<FilterProvider>(
        builder: (context, model, child) => model.filterResult.length == 0
            ? Center(
                child: Text('There are no products in this category'),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    StaggeredGridView.countBuilder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount: model.loading ? 6 : model.filterResult.length,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 16,
                      staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                      itemBuilder: (BuildContext context, int index) =>
                          // if loading show product grid placeholder
                          model.loading
                              ? ProductPlaceHolder()
                              : ProductCell(item: model.filterResult[index]),
                    ),
                    FlatButton(
                      onPressed: () {
                        model.fetchMore(widget.category.id);
                      },
                      child: Text('Load more'),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
