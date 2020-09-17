import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/services/firebase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier {
  String _id;
  String _number;

  String get uid => _id;
  String get phoneNumber => _number;

  AccountDetails _accountDetails;
  AccountDetails get accountDetailes => _accountDetails;
/*   AccountDetails get accountDetailes => AccountDetails(
        name: 'Akshay Asok',
        phoneNumber: '7356220556',
        addresses: [
          Address(
            buildingName: 'Sreehari',
            city: 'Kollam',
            landmark: 'Decent Jn',
            name: 'Akshay',
            phoneNumber: '7356220556',
            isDefault: true,
            pincode: '691577',
            state: 'Kerala',
          ),
        ],
      );
 */
  bool _profileFound = false;
  bool get profileFound => _profileFound;

  setUserId(String userId, phone) async {
    _id = userId;
    _number = phone;
  }

  getUserDetailes(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // check if user has setup their account locally if not check firebase
    if (_accountDetails == null) {
      bool setUpCompleate = prefs.getBool('setUpCompleate') ?? false;

      if (setUpCompleate) {
        _accountDetails = AccountDetails.fromDocument(
          await FAPI().getUserDetail(_id),
        );
        _profileFound = true;
        notifyListeners();
      } else {
        bool exist = await FAPI().checkUserDetail(_id);
        if (exist) {
          _accountDetails = AccountDetails.fromDocument(
            await FAPI().getUserDetail(_id),
          );
          _profileFound = true;
          prefs.setBool('setUpCompleate', true);
          notifyListeners();
        } else {
          _profileFound = false;
          notifyListeners();
          // showAlert(context);
        }
      }
    }
  }

  createUserData(AccountDetails accountDetails, context) async {
    bool success = await FAPI().saveUserDetail(
      uid: _id,
      accountDetails: accountDetails,
    );
    if (success) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('setUpCompleate', true);
      getUserDetailes(context);
      Navigator.of(context).pop();
    }
  }

  addNewAddress({Address newAddress, BuildContext context}) async {
    await FAPI().saveAddress(newAddress: newAddress, uid: _id).then((value) {
      if (value == true) {
        _accountDetails.addresses.add(newAddress);
        notifyListeners();
        Navigator.of(context).pop();
      } else {
        print('adding new address failed');
      }
    });
  }

  deleteAddress({Address address}) async {
    await FAPI().deleteAddress(newAddress: address, uid: _id).then((value) {
      if (value == true) {
        _accountDetails.addresses.remove(address);
        notifyListeners();
      } else {
        print('deleting address failed');
      }
    });
  }
}
