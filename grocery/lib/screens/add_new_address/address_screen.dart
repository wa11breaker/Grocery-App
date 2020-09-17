import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

enum AddressType { home, work, other }

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String name, number, buildingName, landmark, city, state, pincode;
  AddressType _addressType = AddressType.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          'Add a new address',
          style: TextStyle(
            color: Colors.black,
            // fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text(
                        'Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextFormField(
                      isNubmer: true,
                      hintText: 'Pincode*',
                      validator: (String value) {
                        if (value.length != 6) {
                          return 'Please enter a valid pin code';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        pincode = value;
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
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: MyTextFormField(
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
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          flex: 2,
                          child: MyTextFormField(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text(
                        'About',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: Text(
                      'Address Type',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RadioListTile<AddressType>(
                    activeColor: primaryColor,
                    title: const Text(
                      'Home Address',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: AddressType.home,
                    groupValue: _addressType,
                    onChanged: (AddressType value) {
                      setState(() {
                        _addressType = value;
                      });
                    },
                  ),
                  RadioListTile<AddressType>(
                    activeColor: primaryColor,
                    title: const Text(
                      'Work/Office Address',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: AddressType.work,
                    groupValue: _addressType,
                    onChanged: (AddressType value) {
                      setState(() {
                        _addressType = value;
                      });
                    },
                  ),
                  RadioListTile<AddressType>(
                    activeColor: primaryColor,
                    title: const Text(
                      'Other',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: AddressType.other,
                    groupValue: _addressType,
                    onChanged: (AddressType value) {
                      setState(() {
                        _addressType = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    // hide keybord
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
                          type: _addressType.toString(),
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
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
            // hintText: hintText,
            contentPadding: EdgeInsets.only(bottom: 0),
            labelText: hintText,
            alignLabelWithHint: true,
            labelStyle: TextStyle(fontSize: 14)
            // border: InputBorder.none,
            // filled: true,
            // fillColor: Colors.grey[50],,
            ),
        validator: validator,
        onSaved: onSaved,
        keyboardType:
            isNubmer == null ? TextInputType.text : TextInputType.number,
      ),
    );
  }
}

/* class MyTextFormField extends StatelessWidget {
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
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextFormField(
          cursorColor: primaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(15.0),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
          ),
          validator: validator,
          onSaved: onSaved,
          keyboardType:
              isNubmer == null ? TextInputType.text : TextInputType.number,
          textCapitalization: TextCapitalization.words,
        ),
      ),
    );
  }
}
 */
