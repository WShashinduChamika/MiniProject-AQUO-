import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SensorDataComponent extends StatefulWidget {
  final double top;
  final double leftOfPrecentage;
  final String txt1;
  final String txt2;
  final String txt3;
  const SensorDataComponent({
    super.key,
    required this.top,
    required this.leftOfPrecentage,
    required this.txt1,
    required this.txt2,
    required this.txt3,
  });

  @override
  State<SensorDataComponent> createState() => _SensorDataComponentState();
}

class _SensorDataComponentState extends State<SensorDataComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.9.w, top: widget.top),
      height: 42.51.h,
      width: 312.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 41.34.h,
            width: 41.34.w,
            decoration: BoxDecoration(
              color: Color(0xFF7D00B5),
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: const Image(
              image: AssetImage('images/soil_moisture_level/icon.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 13.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.txt1,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,

                    color: Color(0xFF272D3B),
                    //color: Color(0xFFBA58E6),
                  ),
                ),
                Text(
                  widget.txt2,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF272D3B),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: widget.leftOfPrecentage),
            child: Text(
              widget.txt3,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: Color(0xFF272D3B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
