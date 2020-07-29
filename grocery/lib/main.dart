import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/filter_grid.dart';
import 'package:grocery/screens/_init/root.dart';
import 'package:grocery/screens/login/login.dart';
import 'package:grocery/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/get_banners.dart';
import 'providers/login_provider.dart';
import 'utilities/appStrings.dart';
import 'utilities/color.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProvider<GetBanners>(
          create: (context) => GetBanners(),
        ),
        ChangeNotifierProvider<LoginWithPhone>(
          create: (context) => LoginWithPhone(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
          accentColor: Colors.white,
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
        home: Root()
        
       /*  StreamBuilder<FirebaseUser>(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              FirebaseUser user = snapshot.data;
              if (user != null) {
                return Root();
              }
              return Login();
            } else {
              return SplashScreen();
            }
          },
        ), */
      ),
    );
  }
}
