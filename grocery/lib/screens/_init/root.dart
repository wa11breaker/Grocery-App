import 'package:flutter/material.dart';
import 'package:grocery/providers/get_banners.dart';
import 'package:grocery/providers/get_category.dart';
import 'package:grocery/providers/get_featured.dart';
import 'package:grocery/screens/cart/cart.dart';
import 'package:grocery/screens/home/home.dart';
import 'package:grocery/screens/profile/profile.dart';
import 'package:grocery/screens/set_up_profile/set_up_profile.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';
import 'package:grocery/providers/user_data.dart';

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
    Provider.of<FeaturedProduct>(context, listen: false).getFeaturedProduct();
    Provider.of<UserData>(context, listen: false).getUserDetailes(context);
  }

  static final List _bottomNavigationWidgets = [
    HomeScreen(),
    CartScreen(),
    Profile()
  ];
  int _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserData>(
        builder: (context, value, widget) => Stack(
          children: [
            _bottomNavigationWidgets[_navigationIndex],
            value.profileNotFound
                ? Container(
                    color: Colors.black45,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: AlertDialog(
                      content: Container(
                        color: Colors.white,
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Success',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Every Thing went well,\nCongratulation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  height: 1.5),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                elevation: 2,
                                color: primaryColor,
                                child: FlatButton(
                                    child: Text(
                                      'Set Up Your Profile',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SetUpProfile(),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
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
