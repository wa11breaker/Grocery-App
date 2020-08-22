import 'package:flutter/material.dart';
import 'package:grocery/providers/get_featured.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/grid_item.dart';
import 'package:provider/provider.dart';
import 'widgets/banners.dart';
import 'widgets/filter_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of<FilterProvider>(context, listen: false).getFilterResult('');
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
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Category',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(height: 16),
              FilterWidget(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Featured Products',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Consumer<FeaturedProduct>(
                builder: (context, filter, child) => filter.loading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: primaryColor,
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        backgroundColor: Colors.blue,
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 5));
                        },
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filter.featuredProduct.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 24,
                            childAspectRatio: .8,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GridItem(
                              item: filter.featuredProduct[index],
                            );
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
