import 'package:admin/models/order_model.dart';
import 'package:admin/provider/category_items_switch.dart';
import 'package:admin/provider/delivery_boy.dart';
import 'package:admin/provider/sign_in.dart';
import 'package:admin/provider/banners.dart';
import 'package:admin/screens/home/home.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/category_provider.dart';
import 'provider/item_provider.dart';
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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<OrderModel>>(
          create: (_) => FAPI().orders(),
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
        title: 'Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home:
            /* StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, usersnapShot) {
            if (usersnapShot.hasData) {
              return Home();
            }
            if (usersnapShot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Login();
          },
        ), */

            // Home()
            Consumer<SingnIn>(
          builder: (context, value, child) =>
              value.signInSuccess ? Home() : Login(),
        ),
      ),
    );
  }
}
//? flutter run --release -d chrome -v
