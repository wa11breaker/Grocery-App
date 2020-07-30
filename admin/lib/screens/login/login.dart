import 'package:admin/provider/sign_in.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle style = TextStyle(fontSize: 16);
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: primaryColor,
              child: Center(
                child: FlutterLogo(
                  colors: Colors.grey,
                  size: 100,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
                      child: Consumer<SingnIn>(
              builder: (context, value, child) => AutofillGroup(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _username,
                        obscureText: false,
                        style: style,
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                        autofillHints: [AutofillHints.username],
                      ),
                      SizedBox(height: 25.0),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        style: style,
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),
                        autofillHints: [AutofillHints.password],
                      ),
                      value.signInError
                          ? Text(
                              value.errorMessage,
                              style: TextStyle(
                                  color: Colors.red[400], fontSize: 12),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 35.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          color: primaryColor,
                          hoverElevation: 10,
                          onPressed: () {
                            value.signIn(
                              userName: _username.text.trim(),
                              password: _password.text.trim(),
                            );
                          },
                          child: value.loading
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            lightGrey),
                                  ),
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
