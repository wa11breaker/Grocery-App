import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/services/shared_prefs.dart';
import 'package:provider/provider.dart';

class LoginWithPhone extends ChangeNotifier {
  String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  String _verificationId;
  String get verificationId => _verificationId;

  String _otp;
  String get otp => _otp;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _otpError;
  String get otpError => _otpError;

  bool _isOtpScreen = false;
  bool get isOtpScreen => _isOtpScreen;

  void onTextChange(String number) {
    _phoneNumber = number;
  }

  void saveOTP(String otp) {
    _otp = otp;
  }

  validate() {
    if (_phoneNumber.trim().length != 10) {
      _errorMessage = 'Invalid phone number';
      return false;
    } else {
      _errorMessage = '';
      return true;
    }
  }

  Future<void> verifyPhone() async {
    _isOtpScreen = true;
    notifyListeners();
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signIn(authResult, null);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      _otpError = 'Invalid OTP';
      notifyListeners();
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      _verificationId = verId;

      // this.codeSent = true;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      _verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + _phoneNumber,
      timeout: const Duration(minutes: 2),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  signInWithOTP(BuildContext context) async {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _otp,
    );
    signIn(authCreds, context);
  }

  // ignore: missing_return
  signIn(AuthCredential authCreds, BuildContext context) {
    FirebaseAuth.instance.signInWithCredential(authCreds).then((value) async {
      if (value.user != null && context != null) {
        Provider.of<UserData>(context, listen: false)
            .setUserId(value.user.uid, value.user.phoneNumber);
        SharedPrefs().saveUserId(value.user.uid);
      }
    });
  }

  signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    //  Navigator.pushReplacement(
    //           context, MaterialPageRoute(builder: (context) => MyApp()));
  }
}
