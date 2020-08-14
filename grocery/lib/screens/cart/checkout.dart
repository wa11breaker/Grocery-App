import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/providers/cart.dart';
import 'package:grocery/providers/place_order.dart';
import 'package:grocery/providers/user_info.dart';
import 'package:grocery/screens/cart/payment.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/address_block.dart';
import 'package:provider/provider.dart';

enum PaymentMethord { cod, upi }

class UpiPayment extends StatefulWidget {
  @override
  _UpiPaymentState createState() => _UpiPaymentState();
}

class _UpiPaymentState extends State<UpiPayment> {
  PaymentMethord _paymentMethord = PaymentMethord.cod;
  Address address = Address();
  @override
  void initState() {
    super.initState();
    setAddress();
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
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Total Amount : ' + cartValue.subTotal.toString(),
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
                title: const Text('UPI'),
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
                    onPressed: () {
                      if (_paymentMethord.toString() == 'PaymentMethord.upi') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Payment(),
                          ),
                        );
                      } else {
                        Provider.of<PlaceOrder>(context, listen: false)
                            .placeCodOrder(context, address);
                      }
                    },
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
