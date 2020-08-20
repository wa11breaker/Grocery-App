import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delevery_app/screen/order_detailes/order_detailes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    getId();
  }

  getId() async {
    await FirebaseAuth.instance.currentUser().then(
          (value) => setState(
            () {
              user = value;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email == null ? '' : user.email),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('orders')
                .where('orderStatus', isEqualTo: 'ORDER-ASSIGNED')
                .where(
                  'dbID',
                  isEqualTo: user.uid,
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ...snapshot.data.documents.map(
                        (data) => Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetailes(data),
                                  ),
                                ),
                                title: Text(data['name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(data['phone']),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(data['orderAddress']),
                                  ],
                                ),
                                trailing: Icon(Icons.arrow_right),
                              ),
                              Divider(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: Text('No new assigned orders'));
              }
            },
          ),
        ),
      ),
    );
  }
}
