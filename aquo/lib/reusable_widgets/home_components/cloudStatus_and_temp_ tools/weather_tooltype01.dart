import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherToolType01 extends StatefulWidget {
  final bool isClicked;
  final bool isSwitchOn;
  final Function(bool) isSwitchOnValue;
  const WeatherToolType01(
      {super.key,
      required this.isClicked,
      required this.isSwitchOn,
      required this.isSwitchOnValue});

  @override
  State<WeatherToolType01> createState() => _WeatherToolType01State();
}

class _WeatherToolType01State extends State<WeatherToolType01> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.isClicked ? 66.w : -266.w,
      top: 248.h,
      child: Container(
        width: 244.w,
        height: 122.h,
        decoration: BoxDecoration(
          color: Color(0xFF5483EF),
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30.h,
              width: 212.w,
              margin: EdgeInsets.only(
                top: 16.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isSwitchOn ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //isSwitchOn = !isSwitchOn;
                      setState(() {
                        bool updateValue = !widget.isSwitchOn;
                        widget.isSwitchOnValue(updateValue);
                      });
                    },
                    child: Container(
                      height: 28.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5FBFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: widget.isSwitchOn
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: 0.w,
                            ),
                            height: 24.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              color: widget.isSwitchOn
                                  ? const Color(0xFF3ED400)
                                  : const Color(0xFFFF007C),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 212.w,
              height: 45.h,
              margin: EdgeInsets.only(
                top: 9.h,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image(
                    image: const AssetImage('images/home/temptool.png'),
                    height: 45.h,
                    width: 22.w,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 26.w),
                    child: Text(
                      'Temperature status',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
