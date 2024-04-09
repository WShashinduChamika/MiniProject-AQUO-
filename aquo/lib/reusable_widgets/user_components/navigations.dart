import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigatorComponent extends StatefulWidget {
  String img1;
  final String type;
  String img3;
  Function() onTap;

  NavigatorComponent({
    super.key,
    required this.img1,
    required this.type,
    required this.img3,
    required this.onTap,
  });

  @override
  State<NavigatorComponent> createState() => _NavigatorComponentState();
}

class _NavigatorComponentState extends State<NavigatorComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: 295.w,
        height: 40.h,
        // height: 0.0431 * height,
        // width: 0.785 * width,
      
        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
        decoration: BoxDecoration(
             color: Color.fromRGBO(241, 241, 241, 0.5),
        ),
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
              top: 10.h,
              left: 2.w,
              //top: height * 0.0123,
              child: Image(
                image: AssetImage(widget.img1),
                height: 13.h,
                width: 13.w,
              ),
            ),
            Positioned(
              top: 5.h,
              left: 20.w,
              child: Text(
                widget.type,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              right: 5.w,
              child: Image(
                image: AssetImage(widget.img3),
                height: 13.h,
                width: 13.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
