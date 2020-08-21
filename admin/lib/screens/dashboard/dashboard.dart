import 'package:admin/services/send_message.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String remainigSMS = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Text(
                'Dashboard',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      spreadRadius: 5,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'View remainign\nmessages',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: primaryColor, fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(remainigSMS),
                      SizedBox(
                        height: 16,
                      ),
                      FlatButton(
                        color: primaryColor,
                        child: Text(
                          'VIEW',
                          style: TextStyle(color: lightGrey, fontSize: 12),
                        ),
                        onPressed: () async {
                          remainigSMS = await remainingSMS();
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          )

          /* Column(
          children: <Widget>[
            Text(
              'Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    spreadRadius: 5,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'View remainign\nmessages',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: primaryColor, fontSize: 14),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(remainigSMS),
                    SizedBox(
                      height: 16,
                    ),
                    FlatButton(
                      color: primaryColor,
                      child: Text(
                        'VIEW',
                        style: TextStyle(color: lightGrey, fontSize: 12),
                      ),
                      onPressed: () async {
                        remainigSMS = await remainingSMS();
                        setState(() {});
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ), */
          ),
    );
  }
}
