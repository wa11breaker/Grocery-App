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
    Provider.of<FilterProvider>(context, listen: false).getFilterResult('');
    return Consumer<FilterProvider>(
      builder: (context, filter, child) => Scaffold(
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
            : RefreshIndicator(
                backgroundColor: Colors.blue,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 5));
                },
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filter.filterList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GridItem(item: filter.filterList[index]);
                  },
                ),
              ),
      ),
    );
  }
}
