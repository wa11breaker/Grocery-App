import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery/screens/home/widgets/filter_icon.dart';
import 'package:provider/provider.dart';
import '../../../providers/get_category.dart';

class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Consumer<GetCategory>(
        builder: (context, model, _) => 
        
        
        
        
        StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount: model.loading ? 8 : model.category.length,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 24,
          // crossAxisSpacing: 32,
          staggeredTileBuilder: (_) => StaggeredTile.fit(1),
          itemBuilder: (BuildContext context, int index) =>
              // if loading show product grid placeholder
              model.loading
                  ? FilterIconPlaceholder()
                  : FilterIcon(category: model.category[index]),
        ),
      ),
    );
  }
}
/* GridView.builder(
        itemCount: 6,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(flex: 5, child: InkWell(
                    onTap: (){},
                  )),
                  Expanded(
                      flex: 5,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('Bt'),
                      ))
                ],
              ),
            ),
          );
        },
      ), */