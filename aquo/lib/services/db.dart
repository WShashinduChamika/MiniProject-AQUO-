import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  //create user collection

  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection("Location");
  
   final CollectionReference IOTCollection =
      FirebaseFirestore.instance.collection("IOTUnit");
   
   final CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection("Notifications");

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

  Future setNotification(docId, uid, String notificationTitle,
      String notificationMessage, String receviedDateTime) async {
    try {
      await notificationCollection.doc(docId).set({
        "UID": uid,
        "Notification Title": notificationTitle,
        "Notification Message": notificationMessage,
        "Received Date Time": receviedDateTime
      });
      return true;
    } catch (e) {}
  }
}
