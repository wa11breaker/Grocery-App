import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: 70, width: 70, child: Image.asset('assets/icon/icon.png')),
      ),
    );
  }
}
