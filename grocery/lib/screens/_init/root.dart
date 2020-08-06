import 'package:flutter/material.dart';
import 'package:grocery/providers/get_banners.dart';
import 'package:grocery/providers/get_category.dart';
import 'package:grocery/screens/cart/cart.dart';
import 'package:grocery/screens/home/home.dart';
import 'package:grocery/screens/profile/profile.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetBanners>(context, listen: false).getBanners();
    Provider.of<GetCategory>(context, listen: false).getCategory();
  }

  static final List _bottomNavigationWidgets = [
    HomeScreen(),
    Cart(),
    Profile()
  ];
  int _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavigationWidgets[_navigationIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 10,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Cart'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
      currentIndex: _navigationIndex,
      selectedItemColor: primaryColor,
      onTap: (int cIndex) {
        setState(() {
          _navigationIndex = cIndex;
        });
      },
    );
  }
}
