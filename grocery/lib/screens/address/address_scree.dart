import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String name, number, buildingName, landmark, city, state, pincode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          'Address',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                  hintText: 'House No, Building name*',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'House No, Building name cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    buildingName = value;
                  },
                ),
                MyTextFormField(
                    hintText: 'Road Name, Area, Colony*',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      landmark = value;
                    }),
                MyTextFormField(
                    hintText: 'City*',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      city = value;
                    }),
                MyTextFormField(
                    hintText: 'State*',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      state = value;
                    }),
                MyTextFormField(
                    isNubmer: true,
                    hintText: 'Pin code*',
                    validator: (String value) {
                      if (value.length != 6) {
                        return 'Please enter a valid pin code';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      pincode = value;
                    }),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Provider.of<UserData>(context, listen: false)
                            .addNewAddress(
                          newAddress: Address(
                            name: name,
                            phoneNumber: number,
                            buildingName: buildingName,
                            landmark: landmark,
                            city: city,
                            state: state,
                            pincode: pincode,
                            isDefault: false,
                          ),
                          context: context,
                        );
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
