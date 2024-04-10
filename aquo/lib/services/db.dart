import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  //create user collection

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("User");

  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection("Location");
  
   final CollectionReference IOTCollection =
      FirebaseFirestore.instance.collection("IOTUnit");
   
   final CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection("Notifications");
   
    final CollectionReference ESPCollection =
      FirebaseFirestore.instance.collection("EspData");
   
  //set user data
  Future setUser(uid, String firstName, String lastName, String email,
      String contactNumber) async {
    try {
      await userCollection.doc(uid).set({
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "ContactNumber": contactNumber,
        "SystemID": "",
        "Profile-img": ""
      });
    } catch (e) {
      print('error is $e');
    }
  }

  Future updateUser(uid, String firstName, String lastName, String email,
      String contactNumber, String systemID) async {
    try {
      print(uid);
      await userCollection.doc(uid).update({
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "ContactNumber": contactNumber,
        "SystemID": systemID
      });
    } catch (e) {
      print('error is $e');
    }
  }

  //get user data
  Future getUser(uid) async {
    try {
      DocumentSnapshot documentSnapshot = await userCollection.doc(uid).get();
      if (documentSnapshot.exists) {
        print("User");
        return documentSnapshot;
      }
    } catch (error) {
      print('error $error');
    }
  }

  Future getUserDP(uid) async {
    try {
      DocumentSnapshot documentSnapshot = await userCollection.doc(uid).get();
      return documentSnapshot;
    } catch (e) {
      print("error $e");
    }
  }

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
  
  //set switch status
  Future setSwitchStatus(uid, String mainSwitchStatus,
      String wateringSwitchStatus, String fertilizerSwitchStatus) async {
    await ESPCollection.doc(uid).update({
      "MainSwitchStatus": mainSwitchStatus,
      "pump": wateringSwitchStatus,
      "FertilizerSwitchStatus": fertilizerSwitchStatus,
    });
  }

  Future getSwitchStatus(uid) async {
    return await ESPCollection.doc(uid).get();
  }

  //get sensor data
  Future getSensorData(uid) async{
    return await ESPCollection.doc(uid).get();
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
