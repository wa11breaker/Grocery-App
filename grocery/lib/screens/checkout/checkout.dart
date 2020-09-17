import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/providers/place_order.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/screens/add_new_address/address_screen.dart';
import 'package:grocery/utilities/app_constants.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/utilities/error_tost.dart';
import 'package:grocery/widgets/address_block.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'widgets/orderr_success.dart';
import 'widgets/title_with_icon.dart';

enum PaymentMethord { cod, online }

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Razorpay _razorpay;

  PaymentMethord _paymentMethord = PaymentMethord.cod;
  Address address = Address();

  bool _pendingOrder = false;

  @override
  void initState() {
    super.initState();
    setAddress();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

// set default address
  setAddress() {
    setState(() {
      address = Provider.of<UserData>(context, listen: false)
          .accountDetailes
          .addresses[0];
    });
  }

  void openCheckout() async {
    var options = {
      'key': RazorpayKey,
      'amount': Provider.of<Cart>(context, listen: false).subTotal * 100,
      'name': RazorpayName,
      'description': RazorpayDescription,
      'prefill': {
        'name':
            Provider.of<UserData>(context, listen: false).accountDetailes.name,
        'phone': Provider.of<UserData>(context, listen: false)
            .accountDetailes
            .phoneNumber
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    placeOrder(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Failed",
      // toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  placeOrder(String paymentId) async {
    setState(() => _pendingOrder = true);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        bool status =
            await Provider.of<PlaceOrder>(context, listen: false).placeCodOrder(
          context: context,
          address: address,
          cod: _paymentMethord == PaymentMethord.online ? false : true,
          paymentId: _paymentMethord == PaymentMethord.online ? paymentId : '',
        );

        if (status == true) {
          orderSuccessDialogBox(status);
        } else {
          networkError();
        }
      } else {
        networkError();
      }
    } on SocketException catch (_) {
      // show toast
      networkError();
    }
  }

  networkError() {
    networkErrorToast();
    setState(() => _pendingOrder = false);
  }

// show a dialog box if order is successfully placed
  orderSuccessDialogBox(bool value) {
    if (value == true) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return OrderSuccess();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 3,
            backgroundColor: Colors.grey[50],
            title: Text(
              'Delivery Options',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: Consumer<Cart>(
              builder: (context, cartValue, _) => ListView(
                children: <Widget>[
                  TitlewithIcon(
                      icon: Icons.closed_caption, title: 'Order Summery'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Item : ' +
                                cartValue.cartItemList.length.toString(),
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Total Amount : ' + cartValue.subTotal.toString(),
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TitlewithIcon(
                      icon: Icons.delete_outline, title: 'Delivery Details'),
                  AddressBlock(
                    address: address,
                    deleteOption: false,
                  ),
                  Consumer<UserData>(
                    builder: (context, value, _) => Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          child: Text(
                            'Add New Address',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddressScreen(),
                              ),
                            );
                          },
                        ),
                        if (value.accountDetailes.addresses.length > 1)
                          FlatButton(
                            child: Text(
                              'Select Address',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              _showAddress();
                            },
                          )
                      ],
                    ),
                  ),
                  TitlewithIcon(
                    icon: Icons.credit_card,
                    title: 'Select a payment method',
                  ),
                  RadioListTile<PaymentMethord>(
                    activeColor: primaryColor,
                    title: const Text(
                      'Cash On Delivery',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: PaymentMethord.cod,
                    groupValue: _paymentMethord,
                    onChanged: (PaymentMethord value) {
                      setState(() {
                        _paymentMethord = value;
                      });
                    },
                  ),
                  RadioListTile<PaymentMethord>(
                    title: const Text(
                      'Pay online',
                      style: TextStyle(fontSize: 14),
                    ),
                    activeColor: primaryColor,
                    value: PaymentMethord.online,
                    groupValue: _paymentMethord,
                    onChanged: (PaymentMethord value) {
                      setState(() {
                        _paymentMethord = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          if (_paymentMethord == PaymentMethord.online) {
                            openCheckout();
                          } else {
                            placeOrder('');
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        elevation: 5,
                        color: primaryColor,
                        child: Text(
                          'Place Order',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_pendingOrder) ...[
          Opacity(
            opacity: 0.3,
            child: const ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        'Please wait...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }

  Future<void> _showAddress() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an address'),
          content: Consumer<UserData>(
            builder: (context, value, _) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...value.accountDetailes.addresses.map(
                    (e) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            address = e;
                          });
                          Navigator.of(context).pop();
                        },
                        child: AddressBlock(
                          address: e,
                        ),
                      );
                    },
                  ).toList()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
