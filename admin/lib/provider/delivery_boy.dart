import 'package:admin/models/deliveryboy_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeliveryBoyProvider extends ChangeNotifier {
  List<DeliveryBoyModle> _deliveryBoys = List();
  List<DeliveryBoyModle> get deliveryBoy => _deliveryBoys;

  fetchDeliveryBoyLIst() async {
    if (_deliveryBoys.length == 0) {
      var snapshot =
          await Firestore.instance.collection('deliveryBoy').getDocuments();
      snapshot.documents.forEach(
        (doc) => _deliveryBoys.add(DeliveryBoyModle.fromDoc(doc.data)),
      );
      notifyListeners();
    }
  }

  addNewDeliveryBoy(
      {BuildContext context,
      String email,
      String password,
      String name}) async {
    var data = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await Firestore.instance
        .collection('deliveryBoy')
        .document(data.user.uid)
        .setData({
      'name': name,
      'email': email,
      'id': data.user.uid,
    }).then((value) {
      _deliveryBoys.add(
        DeliveryBoyModle(email: email, id: data.user.uid, name: name),
      );
      notifyListeners();
      Navigator.of(context).pop();
    });
  }
}
