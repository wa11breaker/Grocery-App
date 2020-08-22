import 'package:delevery_app/screen/login/login_screen.dart';
import 'package:delevery_app/utilites/color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screen/home/home_screen.dart';

void main() {
  // Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    return MaterialApp(
      title: 'Capital DB',
      theme: ThemeData(
        // primarySwatch: primaryColor,
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData && (!snapshot.data.isAnonymous)) {
            return Home();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Splash();
          }
          return Login();
        },
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.jpg',
          scale: 6,
        ),
      ),
    );
  }
}
