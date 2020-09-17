import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery/providers/cart.dart';
import 'providers/filter_grid.dart';
import 'package:provider/provider.dart';
import 'providers/get_banners.dart';
import 'providers/get_category.dart';
import 'providers/get_featured.dart';
import 'providers/login_provider.dart';
import 'providers/place_order.dart';
import 'providers/splash_screen.dart';
import 'providers/user_data.dart';
import 'screens/splash_screen/splash.dart';
import 'utilities/appStrings.dart';
import 'utilities/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // firebase auth Stream
        StreamProvider<User>.value(
          value: FirebaseAuth.instance.authStateChanges(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProvider<GetBanners>(
          create: (context) => GetBanners(),
        ),
        ChangeNotifierProvider<LoginWithPhone>(
          create: (context) => LoginWithPhone(),
        ),
        ChangeNotifierProvider<GetCategory>(
          create: (context) => GetCategory(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider<UserData>(
          create: (context) => UserData(),
        ),
        ChangeNotifierProvider<PlaceOrder>(
          create: (context) => PlaceOrder(),
        ),
        ChangeNotifierProvider<FeaturedProduct>(
          create: (context) => FeaturedProduct(),
        ),
        ChangeNotifierProvider<SplashScreenProvider>(
          create: (context) => SplashScreenProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
          accentColor: Colors.grey,
          accentColorBrightness: Brightness.light,
          textTheme: TextTheme(
            headline5: TextStyle(
              color: grey,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            bodyText2: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: grey,
                  fontWeight: FontWeight.normal,
                ),
            bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: grey,
                  fontWeight: FontWeight.normal,
                ),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: grey,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreenWidget(),
      ),
    );
  }
}
// Todo!
/* 
cache user data and address
 */
