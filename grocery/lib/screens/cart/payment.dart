import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grocery/providers/cart.dart';
import 'package:provider/provider.dart';
import 'package:upi_pay/upi_pay.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String _upiAddrError;

  Future<List<ApplicationMeta>> _appsFuture;

  @override
  void initState() {
    super.initState();

    _appsFuture = UpiPay.getInstalledUpiApplications();
  }

  // this will open correspondence UPI Payment gateway app on which user has tapped.
  Future<void> _openUPIGateway(ApplicationMeta app) async {
    setState(() {
      _upiAddrError = null;
    });

    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    print("Starting transaction with id $transactionRef");

    // this function will initiate UPI transaction.
    final a = await UpiPay.initiateTransaction(
      amount: Provider.of<Cart>(context).subTotal.toString(),
      app: app.upiApplication,
      receiverName: 'Sharad',
      receiverUpiAddress: 'akshayasok1998-2@okhdfcbank',
      transactionRef: transactionRef,
      merchantCode: '7372',
    );

    print(a);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 128, bottom: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Pay Using',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                if (_upiAddrError != null)
                  Container(
                    margin: EdgeInsets.only(top: 4, left: 12),
                    child: Text(
                      _upiAddrError,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                FutureBuilder<List<ApplicationMeta>>(
                  future: _appsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Container();
                    }

                    return GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.6,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data
                          .map(
                            (i) =>
                                /*  ListTile(
                                        leading: CircleAvatar(
                                          child: Image.memory(
                                            i.icon,
                                            width: 64,
                                            height: 64,
                                          ),
                                        ),
                                        title: Text(
                                          i.upiApplication.getAppName(),
                                        ),
                                      ) */

                                Material(
                              key: ObjectKey(i.upiApplication),
                              color: Colors.grey[200],
                              child: InkWell(
                                onTap: () => _openUPIGateway(i),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.memory(
                                      i.icon,
                                      width: 64,
                                      height: 64,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                        i.upiApplication.getAppName(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
