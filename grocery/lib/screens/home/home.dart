import 'package:flutter/material.dart';
import 'widgets/banners.dart';
import 'widgets/filter_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 32),
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
              // PopularProductGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
