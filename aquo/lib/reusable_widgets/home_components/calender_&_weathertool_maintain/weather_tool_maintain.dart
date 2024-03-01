import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherToolMaintain extends StatefulWidget {
  final Function(bool) isClickedValue;
  //final Function(bool) isAnotherClickedValue;
  final bool isClicked;
  //final bool isAnotherClicked;
  final bool isToolOn;
  final Color bgclr;
  final String img;
  final String txt1;
  final String txt2;
  const WeatherToolMaintain(
      {required this.isClickedValue,
      //  required this.isAnotherClickedValue,
      //  required this.isAnotherClicked,
      required this.isToolOn,
      required this.bgclr,
      required this.img,
      required this.txt1,
      required this.txt2,
      required this.isClicked});

  @override
  State<WeatherToolMaintain> createState() => _WeatherToolMaintainState();
}

class _WeatherToolMaintainState extends State<WeatherToolMaintain> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              bool updateVlaue = !widget.isClicked;
              widget.isClickedValue(updateVlaue);
            });
          },
          child: Container(
            height: 28.h,
            width: 28.w,
            decoration: BoxDecoration(
              color: widget.bgclr,
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
            ),
            child: Image(
              height: 14.h,
              width: 14.w,
              // ignore: unnecessary_string_interpolations
              image: AssetImage('${widget.img}'),
            ),
          ),
        ),
        Container(
          height: 45.h,
          width: 60.w,
          margin: EdgeInsets.only(left: 7.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.txt1}',
                style: TextStyle(
                  fontFamily: 'Muli',
                  fontWeight: FontWeight.normal,
                  fontSize: 10.sp,
                  color: Color(0xFF0D1904),
                ),
              ),
              Text(
                widget.isToolOn ? '${widget.txt2}' : '',
                style: TextStyle(
                  fontFamily: 'Muli',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Color(0xFF0D1904),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
