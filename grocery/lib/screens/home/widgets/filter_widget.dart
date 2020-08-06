import 'package:flutter/material.dart';
import 'package:grocery/screens/home/widgets/filter_icon.dart';
import 'package:provider/provider.dart';
import '../../../providers/get_category.dart';

class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetCategory>(
      builder: (context, value, _) => SizedBox(
        height: 90,
        child: ListView.builder(
          itemCount: value.category.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return FilterIcon(category: value.category[index]);
          },
        ),
      ),
    );
  }
}
