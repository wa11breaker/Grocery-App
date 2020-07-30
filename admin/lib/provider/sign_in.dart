import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingnIn extends ChangeNotifier {
  bool _signInSucceess = false;
  bool get signInSuccess => _signInSucceess;

  String _errorMessage;
  String get errorMessage => _errorMessage;

  bool _signInError = false;
  bool get signInError => _signInError;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn({String userName, password}) async {
    // ignore: unused_local_variable
    FirebaseUser user;
    _loading = true;
    _signInError = false;
    _signInSucceess=true;
    notifyListeners();

    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
      user = result.user;
      _loading = false;
      notifyListeners();
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          _errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          _errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          _errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          _errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          _errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          _errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          _errorMessage = "An undefined Error happened.";
      }
      _signInError = true;
      _loading = false;
      notifyListeners();
    }
  }
}
