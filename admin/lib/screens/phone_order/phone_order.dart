import 'dart:convert';

import 'package:admin/provider/phone_order_logic/cart.dart';
import 'package:admin/provider/phone_order_logic/get_items.dart';
import 'package:admin/provider/phone_order_logic/place_order.dart';
import 'package:admin/screens/phone_order/cartitem.dart';
import 'package:admin/utilities/color.dart';
import 'package:admin/widgets/gridItem.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PhoneOrderEntry extends StatefulWidget {
  PhoneOrderEntry({Key key}) : super(key: key);

  @override
  _PhoneOrderEntryState createState() => _PhoneOrderEntryState();
}

class _PhoneOrderEntryState extends State<PhoneOrderEntry> {
  final _formKey = GlobalKey<FormState>();
  String name, number, buildingName, landmark, city, state, pincode;

  String deliveryTime;
  String deliveryDate;

  List<TimeSlot> tslot = [
    TimeSlot(from: 7.5, to: 10.5, timeString: '07:30 AM  -  10:30 AM'),
    TimeSlot(from: 12.5, to: 14.0, timeString: '12:30 PM  -  02:00 PM'),
    TimeSlot(from: 15.5, to: 17.5, timeString: '03:30 PM  -  05:30 PM'),
    TimeSlot(from: 17.5, to: 19.5, timeString: '05:30 PM  -  07:00 PM'),
  ];
  List<TimeSlot> newTimeslot = List();
  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
  var today = DateTime.now();

  cal() {
    newTimeslot.clear();
    var today = DateTime.now();
    double currentTime =
        toDouble(TimeOfDay(hour: today.hour, minute: today.minute));
    for (var i in tslot) {
      if (currentTime < i.from && currentTime < i.to) {
        newTimeslot.add(i);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cal();
    Provider.of<FilterProvider>(context, listen: false).getFilterResult();
  }

  placeOrder(String paymentId) {
    String address = '$buildingName, $landmark, $city, $state, $pincode';

    if (deliveryDate != null) {
      Provider.of<PlaceOrder>(context, listen: false)
          .placeCodOrder(
            name: name.trim(),
            phoneNumber: number.trim(),
            context: context,
            address: address.trim(),
            cod: false,
            paymentId: paymentId,
            deliveryTime: deliveryTime,
            deliveryDate: deliveryDate,
          )
          .then((value) => showstatus(value));
    } else {
      Fluttertoast.showToast(
        msg: "Select delivery time",
        // toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
                      /*  Navigator.popUntil(context,
                          ModalRoute.withName(Navigator.defaultRouteName)); */
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
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                MyTextFormField(
                  hintText: 'Name',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    name = value;
                  },
                ),
                MyTextFormField(
                  isNubmer: true,
                  hintText: '10-digit mobile number*',
                  validator: (String value) {
                    if (value.length != 10) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    number = value;
                  },
                ),
                MyTextFormField(
                  hintText: 'Full Address',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Address cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    buildingName = value;
                  },
                ),
                Container(
                  color: Colors.grey[50],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (deliveryTime != null && deliveryDate != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deliveryTime,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              deliveryDate,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      FlatButton(
                        onPressed: () => _selectTimeSlot(),
                        child: Text(
                          'Select time slot',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer<FilterProvider>(
                      builder: (context, value, _) => SizedBox(
                          height: 300,
                          width: 500,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  'All Products',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                                value.filterResult == null ||
                                        value.filterResult.length == 0
                                    ? Center(child: CircularProgressIndicator())
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: Scrollbar(
                                            child: GridView.builder(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 32, 16, 0),
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  value.filterResult.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 16,
                                                mainAxisSpacing: 24,
                                                childAspectRatio: 1,
                                              ),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GridItem(
                                                  item:
                                                      value.filterResult[index],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          )),
                      // ),
                    ),
                    Consumer<Cart>(
                      builder: (context, value, _) => SizedBox(
                        height: 300,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cart',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: value.cartItemList.length,
                                  itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CartItemTile(
                                          index: index,
                                        ),
                                      )
                                  // cartTile(value, index),
                                  ),
                              Row(
                                children: [
                                  Text('Total Price :  '),
                                  Text(
                                    '₹ ' + value.subTotal.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        placeOrder('');
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 5,
                    color: primaryColor,
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectTimeSlot() async {
    String dateFormatter(DateTime date) {
      dynamic dayData =
          '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';

      dynamic monthData =
          '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "May", "6" : "June", "7" : "Jul", "8" : "Aug", "9" : "Sep", "10" : "Oct", "11" : "Nov", "12" : "Dec" }';

      return json.decode(dayData)['${date.weekday}'] +
          ", " +
          date.day.toString() +
          " " +
          json.decode(monthData)['${date.month}'];
      // " " +
      // date.year.toString();
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a delivery slot'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (newTimeslot.length != 0)
                  Container(
                    width: double.infinity,
                    color: lightGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: RichText(
                        text: TextSpan(
                          text: dateFormatter(today),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '    Today',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ...newTimeslot
                    .map((e) => timeSlotTile(e, dateFormatter(today)))
                    .toList(),
                Container(
                  width: double.infinity,
                  color: lightGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: RichText(
                      text: TextSpan(
                        text: dateFormatter(
                          today.add(
                            Duration(days: 1),
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '    Tomorrow',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ...tslot
                    .map(
                      (e) => timeSlotTile(
                        e,
                        dateFormatter(
                          today.add(
                            Duration(days: 1),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget timeSlotTile(TimeSlot e, String passedDay) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
            onTap: () {
              setState(() {
                deliveryTime = e.timeString;
                deliveryDate = passedDay;
              });
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(e.timeString),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }
}

class TimeSlot {
  double from;
  double to;
  String timeString;

  TimeSlot({this.from, this.to, this.timeString});
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isNubmer;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isNubmer,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextFormField(
          cursorColor: primaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(15.0),
            border: InputBorder.none,
            filled: true,
            fillColor: lightGrey,
          ),
          validator: validator,
          onSaved: onSaved,
          keyboardType:
              isNubmer == null ? TextInputType.text : TextInputType.number,
        ),
      ),
    );
  }
}
