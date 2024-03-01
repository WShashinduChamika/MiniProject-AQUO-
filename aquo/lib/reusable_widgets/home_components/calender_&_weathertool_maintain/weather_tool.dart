import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WheatherTool extends StatefulWidget {
  //const WheatherTool({super.key});
  final Function(bool) isToolOnValue;
  //final Function(String) weatherDataValue;
  final bool isClicked;
  final bool isToolOn;
  final double left;
  final Color clr;
  final Image img;
  final String statusType;

  // final WeatherService wservice =
  //     WeatherService('17616021dbc6c5abe5bb6d8029d52b99');

  WheatherTool({
    required this.isClicked,
    required this.isToolOnValue,
    //required this.weatherDataValue,
    required this.isToolOn,
    required this.left,
    required this.clr,
    required this.img,
    required this.statusType,
  });

  @override
  State<WheatherTool> createState() => _WheatherToolState();
}

class _WheatherToolState extends State<WheatherTool> {
  //bool isHumidityClicked = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.isClicked ? widget.left : -266.w,
      top: 228.h,
      child: Container(
        width: 160.w,
        height: 200.h,
        decoration: BoxDecoration(
          color: widget.clr,
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30.h,
              width: 128.w,
              margin: EdgeInsets.only(
                top: 16.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isToolOn ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                  Container(
                    height: 28.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FBFF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: widget.isToolOn
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //isSwitchOn = !isSwitchOn;
                            setState(() {
                              bool updatedValue = !widget.isToolOn;
                              widget.isToolOnValue(updatedValue);
                              // String weatherData =
                              //     getWeatherDetails().toString();
                              // widget.weatherDataValue(weatherData);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 0.w,
                            ),
                            height: 24.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              color: widget.isToolOn
                                  ? const Color(0xFF3ED400)
                                  : const Color(0xFFFF007C),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 128.w,
              height: 90.h,
              margin: EdgeInsets.only(
                top: 54.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.img,
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text(
                      widget.statusType,
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
