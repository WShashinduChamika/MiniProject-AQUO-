import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusLevel extends StatefulWidget {
  final Color bgclr;
  final String img;
  final String txt1;
  final String txt2;
  final String txt3;
  final Color arrowBgClr;
  final Function() navigateT0;
  const StatusLevel({
    super.key,
    required this.bgclr,
    required this.img,
    required this.txt1,
    required this.txt2,
    required this.txt3,
    required this.arrowBgClr,
    required this.navigateT0,
  });

  @override
  State<StatusLevel> createState() => _StatusLevelState();
}

class _StatusLevelState extends State<StatusLevel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.navigateT0();
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        height: 129.h,
        width: 104.w,
        decoration: BoxDecoration(
          color: widget.bgclr,
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10.h,
                left: 10.w,
              ),
              child: Image(
                width: 16.w,
                height: 19.h,
                image: AssetImage(widget.img),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 12.h,
                left: 10.w,
              ),
              child: Text(
                widget.txt1,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 2.h,
                left: 10.w,
              ),
              child: Text(
                widget.txt2,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 9.sp,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 1.h,
                left: 10.w,
              ),
              child: Text(
                widget.txt3,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 9.sp,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 3.h,
                left: 67.w,
              ),
              height: 26.h,
              width: 26.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.arrowBgClr,
              ),
              child: Image(
                height: 8.h,
                width: 9.w,
                image: const AssetImage('images/home/arrow.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
