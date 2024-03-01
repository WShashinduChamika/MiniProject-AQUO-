import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime currentDate = DateTime.now();
  bool isLightClicked = false;
  bool isLightToolOn = false;
  @override
  Widget build(BuildContext context) {
    String formattedDataDay01 = DateFormat('d').format(currentDate);
    String dayName01 = DateFormat('EEE').format(currentDate);

    DateTime secondDate = currentDate.add(
      Duration(days: 1),
    );
    String formattedDataDay02 = DateFormat('d').format(secondDate);
    String dayName02 = DateFormat('EEE').format(secondDate);

    DateTime thirdDate = currentDate.add(
      Duration(days: 2),
    );
    String formattedDataDay03 = DateFormat('d').format(thirdDate);
    String dayName03 = DateFormat('EEE').format(thirdDate);

    DateTime fourthDate = currentDate.add(
      Duration(days: 3),
    );
    String formattedDataDay04 = DateFormat('d').format(fourthDate);
    String dayName04 = DateFormat('EEE').format(fourthDate);

    DateTime fifthDate = currentDate.add(
      Duration(days: 4),
    );
    String formattedDataDay05 = DateFormat('d').format(fifthDate);
    String dayName05 = DateFormat('EEE').format(fifthDate);

    return Container(
      height: 49.h,
      width: 301.w,
      //color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getCalenderDate(true, true, formattedDataDay01, dayName01),
          getCalenderDate(true, false, formattedDataDay02, dayName02),
          getCalenderDate(true, false, formattedDataDay03, dayName03),
          getCalenderDate(true, false, formattedDataDay04, dayName04),
          getCalenderDate(true, false, formattedDataDay05, dayName05),
          getCalenderDate(false, false, formattedDataDay05, dayName05),
        ],
      ),
    );
  }

  Widget getCalenderDate(
      bool isCalenderDate, bool isFirstadate, String date, String dateName) {
    return Container(
      height: 49.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: isFirstadate ? const Color(0xFF3ED400) : const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.all(
          Radius.circular(6.r),
        ),
      ),
      child: isCalenderDate
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color:
                        isFirstadate ? const Color(0xFFFFFFFF) : Colors.black,
                  ),
                ),
                Text(
                  dateName,
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                    color:
                        isFirstadate ? const Color(0xFFFFFFFF) : Colors.black,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  height: 15.h,
                  width: 14.w,
                  image: const AssetImage('images/home/calender.png'),
                ),
              ],
            ),
    );
  }
}
