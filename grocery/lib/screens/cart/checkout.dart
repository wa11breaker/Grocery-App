import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/providers/place_order.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/address_block.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

enum PaymentMethord { cod, upi }

class UpiPayment extends StatefulWidget {
  @override
  _UpiPaymentState createState() => _UpiPaymentState();
}

class _UpiPaymentState extends State<UpiPayment> {
  Razorpay _razorpay;

  PaymentMethord _paymentMethord = PaymentMethord.cod;
  Address address = Address();
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

  setAddress() {
    List<Address> adrs =
        Provider.of<UserData>(context, listen: false).accountDetailes.addresses;
    for (Address i in adrs) {
      if (i.isDefault == true) {
        setState(() {
          address = i;
        });
      }
    }
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_NanEa92dms1mK4',
      'amount': Provider.of<Cart>(context, listen: false).subTotal * 100,
      'name': 'Capital Supply',
      'description': 'Grow naturally',
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
        fontSize: 16.0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  placeOrder(String paymentId) {
    if (_paymentMethord.toString() == 'PaymentMethord.upi') {
      Provider.of<PlaceOrder>(context, listen: false)
          .placeCodOrder(
            context: context,
            address: address,
            cod: false,
            paymentId: paymentId,
          )
          .then((value) => showstatus(value));
    } else {
      Provider.of<PlaceOrder>(context, listen: false)
          .placeCodOrder(context: context, address: address, cod: true)
          .then((value) => showstatus(value));
    }
  }

  showstatus(bool value) {
    if (value == true) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WillPopScope(
            // ignore: missing_return
            onWillPop: () {
              Provider.of<Cart>(context, listen: false).clear();
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/success.png'),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Order Completed Successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green[600],
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Text(
                    'Order number ${Provider.of<PlaceOrder>(context, listen: false).orderId}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Thank you for shopping.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  FlatButton(
                    color: Colors.green,
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false).clear();
                      Navigator.popUntil(context,
                          ModalRoute.withName(Navigator.defaultRouteName));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cartValue, _) => Scaffold(
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
              titleTile(icon: Icons.delivery_dining, title: 'Delivery Options'),
              AddressBlock(
                name: address.name,
                phone: address.phoneNumber,
                address: address.wholeAddress(),
                isDefault: address.isDefault,
              ),
              Consumer<UserData>(
                // ignore: missing_return
                builder: (context, value, _) =>
                    value.accountDetailes.addresses.length > 1
                        ? FlatButton(
                            child: Text('Change Address'),
                            onPressed: () {
                              _showMyDialog();
                            },
                          )
                        : SizedBox.shrink(),
              ),
              titleTile(
                icon: Icons.credit_card,
                title: 'Select a payment method',
              ),
              ListTile(
                tileColor: Colors.grey[50],
                title: const Text('Cash On Delivery'),
                leading: Radio(
                  activeColor: primaryColor,
                  value: PaymentMethord.cod,
                  groupValue: _paymentMethord,
                  onChanged: (PaymentMethord value) {
                    setState(() {
                      _paymentMethord = value;
                    });
                  },
                ),
              ),
              ListTile(
                tileColor: Colors.grey[50],
                title: const Text('Online'),
                leading: Radio(
                  activeColor: primaryColor,
                  value: PaymentMethord.upi,
                  groupValue: _paymentMethord,
                  onChanged: (PaymentMethord value) {
                    setState(() {
                      _paymentMethord = value;
                    });
                  },
                ),
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
                      if (_paymentMethord.toString() == 'PaymentMethord.upi') {
                        openCheckout();
                      } else {
                        placeOrder('');
                        // showstatus(true);
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

  Future<void> _showMyDialog() async {
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
                          address: e.wholeAddress(),
                          name: e.name,
                          phone: e.phoneNumber,
                          isDefault: false,
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
