import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  //create user collection

  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection("Location");

  //set location details
  Future setLocation(uid, String longitude, String latitude) async {
    try {
      await locationCollection.doc(uid).set({
        "Longitude": longitude,
        "Latitude": latitude,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //get location details
  Future getLocation(uid) async {
    try {
      return await locationCollection.doc(uid).get();
    } catch (e) {
      print(e);
    }
  }
}
