import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/screens/_init/root.dart';
import 'package:grocery/screens/login/login.dart';
import 'package:grocery/screens/splash_screen/loading.dart';
import 'package:grocery/services/cloud_messaging.dart';
import 'package:provider/provider.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  bool showSplash = true;
  @override
  void initState() {
    super.initState();
    splash();
    PushNotificationsManager().init();
  }

  splash() {
    Future.delayed(Duration(seconds: 3))
        .then((value) => setState(() => showSplash = false));
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    bool loggedIn = user != null;

    if (loggedIn && showSplash == false) {
      Provider.of<UserData>(context).setUserId(user.uid, user.phoneNumber);
      Provider.of<UserData>(context, listen: false).getUserDetailes(context);
      return Root();
    } else if (!loggedIn && showSplash == false) {
      return Login();
    } else {
      return LoadingScreen();
    }
  }
}
