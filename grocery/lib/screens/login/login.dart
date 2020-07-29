import 'package:flutter/material.dart';
import 'package:grocery/providers/login_provider.dart';
import 'package:grocery/screens/login/otp.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                      'Welcome',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text('Sign in to continue'),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Enter Mobile Number'),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(4)),
                        child: TextField(
                          // controller: _phoneNumber,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 16),
                              child: Text(
                                '+91-',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 23,
                              maxHeight: 20,
                            ),

                            // contentPadding: EdgeInsets.only(top: 20),
                          ),
                          onChanged: (numb) => value.onTextChange(numb),
                          onSubmitted: (numb) => value.validate(),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        value.errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (value.validate()) {
                        value.verifyPhone();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => OTPScreen()),
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 5,
                    color: primaryColor,
                    child: Text(
                      'GET OTP',
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
