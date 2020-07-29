import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery/main.dart';
import 'package:grocery/screens/_init/root.dart';

class LoginWithPhone extends ChangeNotifier {
  String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  String _verificationId;
  String get verificationId => _verificationId;

  String _otp;
  String get otp => _otp;

  int _countdown;
  get countdown => _countdown;

  String _time = '';
  String get time => _time;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _otpError;
  String get otpError => _otpError;

  Timer tmr;

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

  void countDown() {
    _countdown = 60 * 2;

    tmr = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown != 0) {
        final int min = _countdown ~/ 60;
        final int sec = _countdown - min * 60;

        _time = min.toString().padLeft(2, '0') +
            ':' +
            sec.toString().padLeft(2, '0');

        _countdown--;
        notifyListeners();
      } else {
        tmr.cancel();
      }
    });
  }

  void resetCountDown() {
    _countdown = 60 * 2;
    countDown();
  }

  Future<void> verifyPhone() async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signIn(authResult,null);
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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Root()));
      }
    });
  }

  signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
  //  Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => MyApp()));
  }
}
