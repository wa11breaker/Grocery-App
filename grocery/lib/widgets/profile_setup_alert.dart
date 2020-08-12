import 'package:flutter/material.dart';
import 'package:grocery/screens/set_up_profile/set_up_profile.dart';
import 'package:grocery/utilities/color.dart';

class SetUpAlert {
  Future<void> setUpProfile(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Success',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Every Thing went well,\nCongratulation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey, fontSize: 14, height: 1.5),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 2,
                      color: primaryColor,
                      child: FlatButton(
                          child: Text(
                            'Set Up Your Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetUpProfile(),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
