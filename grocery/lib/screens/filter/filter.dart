import 'package:flutter/material.dart';
import 'package:grocery/providers/filter_grid.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/grid_item.dart';
import 'package:provider/provider.dart';

class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<FilterProvider>(context, listen: false).getFilterResult('');
    return Consumer<FilterProvider>(
      builder: (context, filter, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Filter',
            style: TextStyle(color: grey),
          ),
        ),
        body: filter.loadingFilterResult
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ),
              )
            : GridView.builder(
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
              ),
      ),
    );
  }
}
