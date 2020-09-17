import 'package:flutter/material.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/providers/get_banners.dart';
import 'package:grocery/providers/get_category.dart';
import 'package:grocery/providers/get_featured.dart';
import 'package:grocery/screens/cart/cart.dart';
import 'package:grocery/screens/home/home.dart';
import 'package:grocery/screens/profile/profile.dart';
import 'package:grocery/screens/set_up_profile/set_up_profile.dart';
import 'package:grocery/utilities/color.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
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
            !value.profileFound
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
      selectedIconTheme: IconThemeData(color: primaryColor),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 10),
      selectedLabelStyle: TextStyle(color: Colors.black, fontSize: 12),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.home),
          title: Text(
            'Home',
          ),
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Icon(
                  LineAwesomeIcons.shopping_cart,
                ),
              ),
              Consumer<Cart>(
                  builder: (context, value, _) => value.cartItemList.length > 0
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(left: 24),
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: Colors.redAccent[200],
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : SizedBox.shrink())
            ],
          ),
          title: Text(
            'Cart',
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.user),
          title: Text(
            'Profile',
          ),
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
