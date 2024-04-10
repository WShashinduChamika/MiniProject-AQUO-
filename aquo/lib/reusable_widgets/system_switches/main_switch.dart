import 'package:aquo/global.dart';
import 'package:aquo/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainSwitch extends StatefulWidget {
  final bool isMainSwitchOn;
  final Function(bool) isMainSwitchOnValue;
  final bool isWateringSwitchOn;
  final Function(bool) isWateringSwitchOnValue;
  final bool isFertilizerSwitchOn;
  final Function(bool) isFertilizerSwitchOnValue;
  const MainSwitch(
      {super.key,
      required this.isMainSwitchOn,
      required this.isMainSwitchOnValue,
      required this.isWateringSwitchOn,
      required this.isWateringSwitchOnValue,
      required this.isFertilizerSwitchOn,
      required this.isFertilizerSwitchOnValue});

  @override
  State<MainSwitch> createState() => _MainSwitchState();
}

class _MainSwitchState extends State<MainSwitch> {
   late DatabaseServices _db;
  late FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _db = DatabaseServices();
    _auth = FirebaseAuth.instance;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              !widget.isMainSwitchOn ? 'SYSTEM OFF' : 'SYSTEM ON',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: Color(0xFF272D3B),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 25.w,
              ),
              height: 12.h,
              width: 12.w,
              decoration: BoxDecoration(
                color: !widget.isMainSwitchOn
                    ? const Color(0xFFFF007C)
                    : const Color(0xFF3ED400),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: GestureDetector(
                onTap: () {
                  String uid = systemID;
                  if (systemID.isNotEmpty) {
                    setState(() {
                      bool updateValue = !widget.isMainSwitchOn;
                      widget.isMainSwitchOnValue(updateValue);
                      if (!updateValue) {
                        widget.isFertilizerSwitchOnValue(false);
                        widget.isWateringSwitchOnValue(false);
                        //await _db.setSwitchStatus(uid,false,false,false);
                      }
                    });
                  }
                  if (systemID.isNotEmpty) {
                    if (!widget.isMainSwitchOn) {
                      //_db.setSwitchStatus(uid, true, false, false);
                       _db.setSwitchStatus(uid, "on", "off", "off");
                    } else {
                      // _db.setSwitchStatus(uid, false, false, false);
                      _db.setSwitchStatus(uid, "off", "off", "off");
                    }
                  } else {
                    _showSetSystemIDDialog();
                  }
                },
                child: Image(
                  height: 135.h,
                  width: 135.w,
                  image: !widget.isMainSwitchOn
                      ? const AssetImage('images/home/systemoff.png')
                      : const AssetImage('images/home/systemon.png'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showSetSystemIDDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Set SystemID",
            style: TextStyle(
              color: Color.fromARGB(255, 71, 12, 82),
            ),
          ),
          content: const Text(
            "Please set systemID to switch on the main switch.",
            style: TextStyle(
              color: Color.fromARGB(255, 71, 12, 82),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
