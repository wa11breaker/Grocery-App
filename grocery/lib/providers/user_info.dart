import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/services/firebase_api.dart';
import 'package:grocery/widgets/profile_setup_alert.dart';

class UserData extends ChangeNotifier {
  String _id;
  String _number;

  String get uid => _id;
  String get phoneNumber => _number;

  AccountDetails _accountDetails;
  AccountDetails get accountDetailes => _accountDetails;

  bool _profileNotFound = false;
  bool get profileNotFound => _profileNotFound;

  setUserId(String userId, phone) async {
    _id = userId;
    _number = phone;
    notifyListeners();
  }

  getUserDetailes(context) async {
    bool exist = await FAPI().checkUserDetail(_id);

    if (exist) {
      _accountDetails = AccountDetails.fromDocument(
        await FAPI().getUserDetail(_id),
      );
      _profileNotFound = false;
      notifyListeners();
    } else {
      _profileNotFound = true;
      notifyListeners();
      // showAlert(context);
    }
  }

  createUserData(AccountDetails accountDetails, context) async {
    bool success = await FAPI().saveUserDetail(
      uid: _id,
      accountDetails: accountDetails,
    );
    if (success) {
      Navigator.of(context).pop();
      getUserDetailes(context);
    }
  }

  addNewAddress({Address newAddress, BuildContext context}) async {
    await FAPI().saveAddress(newAddress: newAddress, uid: _id).then((value) {
      if (value) {
        Navigator.of(context).pop();
      } else {
        print('Failed');
      }
    });
  }
}
