import 'package:aquo/global.dart';
import 'package:aquo/reusable_widgets/home_components/status_level/status_level.dart';
import 'package:aquo/screens/future_implement.dart';
import 'package:aquo/screens/soil_moisture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusLevelList extends StatefulWidget {
  const StatusLevelList({super.key});

  @override
  State<StatusLevelList> createState() => _StatusLevelListState();
}

class _StatusLevelListState extends State<StatusLevelList> {
  @override
  Widget build(BuildContext context) {
    return //begining of the bottom part
        SizedBox(
      height: 132.h,
      width: 329.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          StatusLevel(
            bgclr: const Color(0xFF2D62ED),
            img: 'images/home/waterlevel.png',
            txt1: '48.K',
            txt2: 'Water',
            txt3: 'Level',
            arrowBgClr: const Color(0xFF789AF3),
            navigateT0: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FutureImplementScreen()),
              );
            },
          ),
          StatusLevel(
              bgclr: const Color(0xFF7D00B5),
              img: 'images/home/download.png',
              txt1: '48.K',
              txt2: 'Soil',
              txt3: 'Moisture',
              arrowBgClr: const Color(0xFFBA58E6),
              navigateT0: () {
                if (systemID.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SoilMoistureLevel()),
                  );
                } else {
                  _showSetSystemIDDialog();
                }
              }),
          StatusLevel(
            bgclr: const Color(0xFF3ED400),
            img: 'images/home/download.png',
            txt1: '48.K',
            txt2: 'Power',
            txt3: 'Supply',
            arrowBgClr: const Color(0xFF7EE355),
            navigateT0: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FutureImplementScreen()),
                  );
            },
          ),
          StatusLevel(
            bgclr: const Color(0xFFFF007C),
            img: 'images/home/download.png',
            txt1: '48.K',
            txt2: 'Fertilizer',
            txt3: 'Status',
            arrowBgClr: const Color(0xFFE15398),
            navigateT0: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FutureImplementScreen()),
                  );
            },
          ),
          StatusLevel(
            bgclr: const Color(0xFF3ED400),
            img: 'images/home/download.png',
            txt1: '48.K',
            txt2: 'Power',
            txt3: 'Supply',
            arrowBgClr: const Color(0xFF7EE355),
            navigateT0: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FutureImplementScreen()),
                  );
            },
          ),
          StatusLevel(
            bgclr: const Color(0xFF7D00B5),
            img: 'images/home/download.png',
            txt1: '48.K',
            txt2: 'Power',
            txt3: 'Supply',
            arrowBgClr: const Color(0xFFBA58E6),
            navigateT0: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FutureImplementScreen()),
                  );
            },
          ),
        ],
      ),
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
            "Please set systemID for viewing soil moisture status.",
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
