import 'package:flutter/material.dart';
import 'widgets/banners.dart';
import 'widgets/filter_widget.dart';
import 'widgets/grid_view.dart';

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
              SizedBox(height: 16),
              Offers(),
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
              FeaturedProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
