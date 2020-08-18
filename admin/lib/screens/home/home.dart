import 'package:admin/provider/screen_index.dart';
import 'package:admin/screens/banner/banners.dart';
import 'package:admin/screens/category/select_category_icon.dart';
import 'package:admin/screens/dashboard/dashboard.dart';
import 'package:admin/screens/delivery_boy/delivery_boy.dart';
import 'package:admin/screens/home/side_bar/side_bar.dart';
import 'package:admin/screens/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<User> users;
  List<Widget> screen = [
    Orders(),
    Dashboard(),
    SlelctCategoryItems(),
    Banners(),
    DeleveryBoy(),
  ];
  bool sort;

  @override
  void initState() {
    sort = false;
    // users = User.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('home screen rebuild');
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Consumer<ScreenIndex>(
              builder: (context, value, child) {
                return screen[value.index ?? 0];
              },
            ),
          ),
        ],
      ),
    );
  }
}
