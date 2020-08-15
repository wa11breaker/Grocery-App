import 'package:flutter/material.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/providers/filter_grid.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/grid_item.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  final Categorys category;

  const Filter({Key key, this.category}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    Provider.of<FilterProvider>(context, listen: false)
        .getFilterResult(widget.category.id);
    return Consumer<FilterProvider>(
      builder: (context, filter, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.category.name,
            style: TextStyle(color: grey),
          ),
        ),
        body: filter.loadingFilterResult
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ),
              )
            : filter.filterResult.length == 0
                ? Center(child: Text('No products found'))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filter.filterResult.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 24,
                      childAspectRatio: .8,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GridItem(item: filter.filterResult[index]);
                    },
                  ),
      ),
    );
  }
}
