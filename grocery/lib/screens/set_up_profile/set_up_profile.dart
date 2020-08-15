import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class SetUpProfile extends StatefulWidget {
  @override
  _SetUpProfileState createState() => _SetUpProfileState();
}

class _SetUpProfileState extends State<SetUpProfile> {
  final _formKey = GlobalKey<FormState>();
  String name, phoneNumber, buildingName, landmark, city, state, pincode;
  List<String> pincodes = [
    '695005',
    '695008',
    '695562',
    '695040',
    '695002',
    '695003',
    '695009',
    '695013',
    '695004',
    '695012',
    '695038',
    '695033',
    '695027',
    '695016',
    '695023',
    '695011',
    '695024',
    '695034',
    '695001',
    '695014',
    '695010',
    '695035',
    '695013'
  ];

  AccountDetails accountDetails = AccountDetails();
  @override
  void initState() {
    super.initState();
    phoneNumber = Provider.of<UserData>(context, listen: false).phoneNumber;
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'About Me',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MyTextFormField(
                  hintText: 'Full Name',
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'My Delivery Address',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      } else if (!pincodes.contains(value)) {
                        return 'We do not deliver to this pincode at the moment';
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

                        accountDetails.name = name;
                        accountDetails.phoneNumber = phoneNumber;
                        accountDetails.addresses = [
                          Address(
                            name: name,
                            phoneNumber: phoneNumber,
                            buildingName: buildingName,
                            landmark: landmark,
                            city: city,
                            state: state,
                            pincode: pincode,
                            isDefault: true,
                          )
                        ];
                        print(accountDetails);

                        Provider.of<UserData>(context, listen: false)
                            .createUserData(accountDetails, context);
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
          textCapitalization: TextCapitalization.words,
        ),
      ),
    );
  }
}

/* List<String> pincodes = [
  '695005',
  '695008',
  '695014',
  '695562',
  '695004',
  '695014',
  '695040',
  '695024',
  '695002',
  '695003',
  '695003',
  '695009',
  '695013',
  '695004',
  '695033',
  '695012',
  '695038',
  '695033',
  '695010',
  '695027',
  '695001',
  '695016',
  '695023',
  '695011',
  '695024',
  '695034',
  '695001',
  '695014',
  '695010',
  '695035',
  '695013'
];
 */
