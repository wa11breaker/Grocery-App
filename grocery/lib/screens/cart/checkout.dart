import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';
import 'package:upi_pay/upi_pay.dart';

enum PaymentMethord { cod, upi }

class UpiPayment extends StatefulWidget {
  @override
  _UpiPaymentState createState() => _UpiPaymentState();
}

class _UpiPaymentState extends State<UpiPayment> {
  String _upiAddrError;

  Future<List<ApplicationMeta>> _appsFuture;

  @override
  void initState() {
    super.initState();

    _appsFuture = UpiPay.getInstalledUpiApplications();
  }

  @override
  void dispose() {
    super.dispose();
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
      amount: '1',
      app: app.upiApplication,
      receiverName: 'Sharad',
      receiverUpiAddress: '_upiAddressController.text',
      transactionRef: transactionRef,
      merchantCode: '7372',
    );

    print(a);
  }

  PaymentMethord _character = PaymentMethord.cod;

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, _) => Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: Text(
            'Delivery Options',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              titleTile(icon: Icons.paste_sharp, title: 'Order Summery'),
              SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.grey[50],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Item : ' + value.cartItemList.length.toString(),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Total Amount : ' + value.subTotal.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              titleTile(icon: Icons.delivery_dining, title: 'Delivery Options'),
              addressBock(
                name: 'Name',
                phone: '7394885003',
                address: 'SreeeHari Decent jn po Kollam',
              ),
              FlatButton(
                child: Text('Change Address'),
                onPressed: () {},
              ),
              titleTile(icon: Icons.credit_card, title: 'Select payment'),
              ListTile(
                tileColor: Colors.grey[50],
                title: const Text('Cash On Delivery'),
                leading: Radio(
                  activeColor: primaryColor,
                  value: PaymentMethord.cod,
                  groupValue: _character,
                  onChanged: (PaymentMethord value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                tileColor: Colors.grey[50],
                title: const Text('UPI'),
                leading: Radio(
                  activeColor: primaryColor,
                  value: PaymentMethord.upi,
                  groupValue: _character,
                  onChanged: (PaymentMethord value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  color: primaryColor,
                  child: FlatButton(
                      child: Text(
                        'Place Order',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {}),
                ),
              ),

              /*   if (_upiAddrError != null)
                Container(
                  margin: EdgeInsets.only(top: 4, left: 12),
                  child: Text(
                    _upiAddrError,
                    style: TextStyle(color: Colors.red),
                  ),
                ), */
            ],
          ),
        ),
      ),
    );
  }

  ListTile titleTile({IconData icon, String title}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        icon,
        color: primaryColor,
      ),
    );
  }

  SizedBox addressBock({String name, address, phone}) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                height: 1.4,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              address,
              style: TextStyle(height: 1.4),
            ),
            Text(
              phone,
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
/*   Container(
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
                              .map((i) => ListTile(
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
                                      )

                                  // Material(
                                  //   key: ObjectKey(i.upiApplication),
                                  //   color: Colors.grey[200],
                                  //   child: InkWell(
                                  //     onTap: () => _openUPIGateway(i),
                                  //     child: Column(
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       children: <Widget>[
                                  //         Image.memory(
                                  //           i.icon,
                                  //           width: 64,
                                  //           height: 64,
                                  //         ),
                                  //         Container(
                                  //           margin: EdgeInsets.only(top: 4),
                                  //           child: Text(
                                  //             i.upiApplication.getAppName(),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ) */
