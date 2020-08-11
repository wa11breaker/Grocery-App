import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/address.dart';

class UserData extends ChangeNotifier {
  String _id;
  String _name;
  String _phone = '0000000000';
  // String _address = '';
  List<Address> _address = List();

  bool _profileSetupRequired;

  String get phone => _phone;
  String get id => _id;
  List<Address> get address => _address;

  setUserId(String userId, phone) async {
    _id = userId;
    _phone = phone;
    notifyListeners();
  }

  getUserAddress() async {
    /*    var address =
        await Firestore.instance.collection('customers').document(_id).get();
    print(address.data['address']);
    for (var i in address.data['address']) {
      print(i);
    }

    notifyListeners(); */
  }

  editAddress() {}

  addNewAddress(context, {String name, address, phone}) async {
    Address add = Address(address: address, name: name, phone: phone);

    print(name + address + phone);
    try {
      // TODO change gWeFCp0qRfdTdpotYQYNlUck9V33  to _id
      await Firestore.instance
          .collection('customers')
          .document('gWeFCp0qRfdTdpotYQYNlUck9V33')
          .updateData({
        "address": FieldValue.arrayUnion([
          {
            'name': add.name,
            'address': add.address,
            'phone': add.phone,
          }
        ])
      }).then((value) => Navigator.pop(context));
    } catch (e) {
      print(e);
    }
  }
}
