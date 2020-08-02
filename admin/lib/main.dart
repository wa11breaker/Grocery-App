import 'package:admin/provider/category_items_switch.dart';
import 'package:admin/provider/sign_in.dart';
import 'package:admin/screens/home/home.dart';
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
          create: (context) =>ItemProvider() ,
        )
      ],
      child: MaterialApp(
          title: 'Admin',
          theme: ThemeData(
            primarySwatch: primeColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            
          ),
          debugShowCheckedModeBanner: false,
          home: Home()

          // Consumer<SingnIn>(
          //   builder: (context, value, child) =>
          //       value.signInSuccess ? Home() : Login(),
          // ),
          ),
    );
  }
}
