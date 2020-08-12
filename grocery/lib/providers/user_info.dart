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

  bool _noPofile = false;
  bool get noPofile => _noPofile;

  setUserId(String userId, phone) async {
    _id = userId;
    _number = phone;
    notifyListeners();
  }

  getUserDetailes(context) async {
    bool exist = await FAPI().checkUserDetail('gWeFCp0qRfdTdpotYQYNlUck9V3');

    if (exist) {
      _accountDetails = AccountDetails.fromDocument(
        await FAPI().getUserDetail('gWeFCp0qRfdTdpotYQYNlUck9V3'),
      );
      _noPofile = false;
      notifyListeners();
    } else {
      _noPofile = true;
      showAlert(context);
    }
  }

  createUserData(AccountDetails accountDetails, context) async {
    bool success = await FAPI().saveUserDetail(
      uid: 'gWeFCp0qRfdTdpotYQYNlUck9V3',
      accountDetails: accountDetails,
    );
    if (success) {
      Navigator.of(context).pop();
      _noPofile = false;

      getUserDetailes(context);
    }
  }

  showAlert(context) {
    if (_noPofile) SetUpAlert().setUpProfile(context);
    notifyListeners();
  }

  addNewAddress({Address newAddress, BuildContext context}) async {
    await FAPI()
        .saveAddress(newAddress: newAddress, uid: 'gWeFCp0qRfdTdpotYQYNlUck9V3')
        .then((value) {
      if (value) {
        Navigator.of(context).pop();
      } else {
        print('Failed');
      }
    });
  }
}
