import 'package:flutter/material.dart';
import 'package:grocery/providers/filter_grid.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/grid_item.dart';
import 'package:provider/provider.dart';
import 'widgets/banners.dart';
import 'widgets/filter_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<FilterProvider>(context, listen: false).getFilterResult('');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /*     IconButton(
                icon: Icon(Icons.signal_wifi_off),
                onPressed: () =>
                    Provider.of<LoginWithPhone>(context, listen: false)
                        .signOut(context),
              ), */
              SizedBox(height: 16),
              Offers(),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Category',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(height: 32),
              FilterWidget(),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Featured Products',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Consumer<FilterProvider>(
                builder: (context, filter, child) => filter.loadingFilterResult
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
                          itemCount: 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 24,
                            childAspectRatio: .8,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return /* Container(
                              color: Colors.black,
                            ); */
                                GridItem(item: filter.filterList[index]);
                          },
                        ),
                      ),
              ),

              // PopularProductGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
