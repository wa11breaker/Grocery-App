import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/splash_screen.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/screens/_init/root.dart';
import 'package:grocery/screens/login/login.dart';
import 'package:grocery/screens/splash_screen/loading.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashScreenProvider>(context, listen: false).showSplash();
    return Consumer<SplashScreenProvider>(
      builder: (context, value, _) => value.finish
          ? //Root()
          StreamBuilder<FirebaseUser>(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  FirebaseUser user = snapshot.data;
                  if (user != null) {
                    Provider.of<UserData>(context)
                        .setUserId(user.uid, user.phoneNumber);
                    return Root();
                  }
                  return Login();
                } else {
                  return LoadingScreen();
                }
              },
            )
          : Scaffold(
              body: Center(
                child: Image.asset(
                  'assets/logo.jpg',
                  scale: 7,
                ),
              ),
            ),
    );
  }
}
