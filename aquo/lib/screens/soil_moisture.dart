import 'dart:async';

import 'package:aquo/global.dart';
import 'package:aquo/reusable_widgets/soil_moisture_status_component/sensor_data_component.dart';
import 'package:aquo/screens/home.dart';
import 'package:aquo/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kdgaugeview/kdgaugeview.dart';

class SoilMoistureLevel extends StatefulWidget {
  const SoilMoistureLevel({super.key});

  @override
  State<SoilMoistureLevel> createState() => _SoilMoistureLevelState();
}

class _SoilMoistureLevelState extends State<SoilMoistureLevel> {
  final DatabaseServices _db = DatabaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String systemUID = "";
  String temprature = "";
  String moisture = "";

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: systemID.isNotEmpty
              ? FirebaseFirestore.instance
                  .collection("EspData")
                  .doc(systemID)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("EspData")
                  .doc("DHT11")
                  .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(child: CircularProgressIndicator());
            // }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              // Handle the case where the document doesn't exist
              return HomeScreen();
            } else {
              moisture = snapshot.data!.get('Moisture') ?? "0";
            }

            return Stack(
              children: [
                Positioned(
                  top: 18.h,
                  child: Container(
                    height: 48.h,
                    width: 375.w,
                    //color: Colors.amber,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 30.w),
                            child: Image(
                              height: 20.h,
                              width: 10.w,
                              image: AssetImage(
                                  'images/soil_moisture_level/back.png'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 90.w),
                          child: Text(
                            'Soil moisture',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF272D3B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 72.h,
                  left: 13.16.w,
                  child: Container(
                    height: 324.67.h,
                    width: 348.7.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF272D3B)
                              .withOpacity(0.2), // Shadow color
                          spreadRadius: 0, // Spread radius
                          blurRadius: 6, // Blur radius
                          offset:
                              Offset(0, 3), // Offset in the x and y directions
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 18.9.w, top: 25.h),
                          child: Text(
                            'Soil moisture status',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF272D3B),
                            ),
                          ),
                        ),
                        SensorDataComponent(
                          top: 15.h,
                          leftOfPrecentage: 95.43.w,
                          txt1: 'Water precentage',
                          txt2: '1 month',
                          txt3: '25%',
                        ),
                        SensorDataComponent(
                          top: 13.h,
                          leftOfPrecentage: 164.43.w,
                          txt1: 'Dryness',
                          txt2: 'current',
                          txt3: '30%',
                        ),
                        SensorDataComponent(
                            top: 13.h,
                            leftOfPrecentage: 114.43.w,
                            txt1: 'Temprature',
                            txt2: 'daily',
                            txt3: '$temprature C'),
                        SensorDataComponent(
                            top: 13.h,
                            leftOfPrecentage: 82.43.w,
                            txt1: 'Average moisture',
                            txt2: 'current',
                            txt3: '$moisture'),
                        Container(
                          //alignment: Alignment.center,
                          height: 26.h,
                          width: 26.h,
                          margin: EdgeInsets.only(top: 14.h, left: 300.w),
                          decoration: BoxDecoration(
                            color: Color(0xFFBA58E6),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.r),
                            ),
                          ),
                          child: Image(
                            height: 7.86.h,
                            width: 9.34.w,
                            image: AssetImage(
                                'images/soil_moisture_level/arrow.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                Positioned(
                  top: 450.h,
                  left: 60.w,
                  child: Container(
                    height: 300.h,
                    width: 270.w,
                    child: KdGaugeView(
                      minSpeed: 0,
                      maxSpeed: 100,
                      speed: double.parse(moisture),
                      animate: true,
                      duration: const Duration(seconds: 2),
                      unitOfMeasurement: "Moisture",
                      unitOfMeasurementTextStyle:
                          TextStyle(fontSize: 16.sp, color:Color(0xFF7D00B5),),
                      baseGaugeColor: Color.fromARGB(45, 124, 0, 181),
                      activeGaugeColor: const Color(0xFF7D00B5),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future getSensorData(String uid) async {
    DocumentSnapshot documentSnapshot1 = await _db.getUser(uid);
    setState(() {
      systemUID = documentSnapshot1['SystemID'];
      print(systemUID);
    });
    if (systemUID.isNotEmpty) {
      DocumentSnapshot documentSnapshot = await _db.getSensorData(systemUID);
      if (documentSnapshot.exists) {
        setState(() {
          temprature = documentSnapshot['Temperature'];
        });
        print(documentSnapshot['Temperature']);
      } else {
        print("no system");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSensorData(isGmailUser ? _auth.currentUser!.uid : emailUID);
  }

  
}
