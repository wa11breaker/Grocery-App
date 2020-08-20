import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delevery_app/utilites/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'widgets/order_items.dart';

class OrderDetailes extends StatelessWidget {
  final dynamic data;
  OrderDetailes(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customersDetails(data),
                  Divider(),
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data['orderItems'].length,
                    itemBuilder: (context, index) => ItemTile(
                      item: data['orderItems'][index],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                elevation: 5,
                color: primaryColor,
                child: Text(
                  "MARK AS DELIVERED",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text('Are you sure'),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancle'),
                        ),
                        FlatButton(
                          child: Text('Yes'),
                          onPressed: () {
                            Firestore.instance
                                .collection('orders')
                                .document(data.documentID)
                                .updateData({
                              'orderStatus': 'ORDER-DELIVERED',
                            }).then(
                              (value) {
                                getSms(
                                  status: 'Delivered',
                                  name: data['name'],
                                  phone: data['phone'].toString().substring(2),
                                  orderID: data['orderId'],
                                );
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getSms({
    String status,
    String name,
    String phone,
    String orderID,
  }) async {
    try {
      http.get(
        'https://2factor.in/API/R1/?module=TRANS_SMS&apikey=ed6e1d01-e2b8-11ea-9fa5-0200cd936042&to=$phone&from=CPTSPL&templatename=CPTSLY&var1=$name&var2=$orderID&var3=$status',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Widget customersDetails(dynamic data) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order ID #${data['orderId']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          SizedBox(height: 8),
          Text(
            data['name'],
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${data['orderAddress']}',
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: '',
              children: <TextSpan>[
                TextSpan(
                  text: 'Total  ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '₹${data['totalPrice']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          FlatButton(
            color: primaryColor,
            onPressed: () => _launchPhone(phoneNo: data['phone']),
            child: Text(
              data['phone'] + '  CALL',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  _launchPhone({String phoneNo}) async {
    String phone = 'tel:$phoneNo';
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not launch $phone';
    }
  }
}
// 9688889685
// 748377
