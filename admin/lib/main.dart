import 'package:admin/models/order_model.dart';
import 'package:admin/provider/category_items_switch.dart';
import 'package:admin/provider/delivery_boy.dart';
import 'package:admin/provider/sign_in.dart';
import 'package:admin/provider/banners.dart';
import 'package:admin/screens/home/home.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:admin/utilities/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/category_provider.dart';
import 'provider/item_provider.dart';
import 'provider/phone_order_logic/cart.dart';
import 'provider/phone_order_logic/get_items.dart';
import 'provider/phone_order_logic/place_order.dart';
import 'provider/screen_index.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  static Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  MaterialColor primeColor = MaterialColor(0xFF35354E, color);
  MaterialColor accentColor = MaterialColor(0xFF337C36, color);

  @override
  // ignore: override_on_non_overriding_member
  // ignore: unused_field
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlaceOrder>(
          create: (context) => PlaceOrder(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
        StreamProvider<List<OrderModel>>(
          create: (_) => FAPI().orders(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider<SingnIn>(
          create: (context) => SingnIn(),
        ),
        ChangeNotifierProvider<ScreenIndex>(
          create: (context) => ScreenIndex(),
        ),
        ChangeNotifierProvider<CategoryItemSwitch>(
          create: (context) => CategoryItemSwitch(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ItemProvider>(
          create: (context) => ItemProvider(),
        ),
        ChangeNotifierProvider<DeliveryBoyProvider>(
          create: (context) => DeliveryBoyProvider(),
        ),
        ChangeNotifierProvider<BannerProvider>(
          create: (context) => BannerProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Capital Supply Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: _auth.onAuthStateChanged,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData && (!snapshot.data.isAnonymous)) {
              return Home();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              );
            }

            return Login();
          },
        ),
        // Home()
        //     Consumer<SingnIn>(
        //   builder: (context, value, child) =>
        //       value.signInSuccess ? Home() : Login(),
        // ),
      ),
    );
  }
}
//? flutter run --release -d chrome -v
