import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/login_provider.dart';
import 'package:grocery/utilities/color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<LoginWithPhone>(
      builder: (context, value, child) => Scaffold(
        body: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child: FlutterLogo(
                    size: 50,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Verification Code',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Enter the OTP sent to ${value.phoneNumber}'),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PinCodeTextField(
                          length: 6,
                          obsecureText: false,
                          animationType: AnimationType.fade,
                          textInputType: TextInputType.number,

                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            fieldWidth: 30,
                            activeFillColor: lightGrey,
                            activeColor: Colors.grey,
                            selectedColor: Colors.black,
                            inactiveColor: Colors.grey,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          // backgroundColor: Colors.blue.shade50,
                          // enableActiveFill: true,
                          // errorAnimationController: errorController,
                          // controller: textEditingController,
                          onCompleted: (otp) {
                            value.saveOTP(otp);
                          },
                          onChanged: (value) {},
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");

                            return true;
                          },
                        ),
                      ),
                      Text(value.otpError ?? ''),
                      SizedBox(
                        height: 16,
                      ),
                      value.countdown != 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.timer),
                                SizedBox(width: 8),
                                Text(value.time)
                              ],
                            )
                          : RichText(
                              text: TextSpan(
                                text: 'Dont receive the OTP? ',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'RESEND OTP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            )
                      // Text('Dont receive the OTP? RESEND OTP')
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      value.signInWithOTP(context);
                      // value.resetCountDown();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 5,
                    color: primaryColor,
                    child: Text(
                      'VERIFY & PROCEED',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
