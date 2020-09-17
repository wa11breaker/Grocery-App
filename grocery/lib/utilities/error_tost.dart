import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

networkErrorToast() {
  return Fluttertoast.showToast(
    msg: "Please check your Internet connection",
    // toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
