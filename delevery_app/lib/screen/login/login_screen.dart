import 'package:delevery_app/utilites/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _loading = false;

  login() {
    setState(() {
      _loading = true;
    });
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        )
        .then(
          (value) => setState(
            () {
              _loading = false;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Image.asset('assets/logo.jpg'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
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
                          padding: const EdgeInsets.only(right: 20, left: 16),
                          child: Icon(
                            Icons.email,
                          ),
                        ),
                        hintText: 'E-Mail',
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 23,
                          maxHeight: 20,
                        ),

                        // contentPadding: EdgeInsets.only(top: 20),
                      ),
                      // onChanged: (numb) => value.onTextChange(numb),
                      // onSubmitted: (numb) => value.validate(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      controller: _password,
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
                          padding: const EdgeInsets.only(right: 20, left: 16),
                          child: Icon(
                            Icons.lock,
                          ),
                        ),
                        hintText: 'Password',
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 23,
                          maxHeight: 20,
                        ),

                        // contentPadding: EdgeInsets.only(top: 20),
                      ),
                      // onChanged: (numb) => value.onTextChange(numb),
                      // onSubmitted: (numb) => value.validate(),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    ',',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    login();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 5,
                  color: primaryColor,
                  child: !_loading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(lightGrey),
                          ),
                        )
                      : Text(
                          'NEXT',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
