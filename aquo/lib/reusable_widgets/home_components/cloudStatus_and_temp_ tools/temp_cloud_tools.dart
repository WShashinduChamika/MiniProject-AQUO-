import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TempCloudTools extends StatefulWidget {
  final bool isClicked;
  final Function(bool) isClickedValueOn;
  final bool isToolOn;
  final String temprature;
  final String cloud_status;
  const TempCloudTools(
      {super.key,
      required this.isClicked,
      required this.isClickedValueOn,
      required this.temprature,
      required this.isToolOn,
      required this.cloud_status});

  @override
  State<TempCloudTools> createState() => _TempCloudToolsState();
}

class _TempCloudToolsState extends State<TempCloudTools> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 14.w),
          child: Image(
            width: 18.w,
            height: 16.h,
            image: const AssetImage('images/home/cloud.png'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 7.w),
          child: Text(
            widget.cloud_status,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
              color: Color(0xFFEFFAF6),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            //print('cloud ' + widget.cloud_status);
            setState(() {
              bool updateValeu = !widget.isClicked;
              widget.isClickedValueOn(updateValeu);
              //print('Tempreature ' + widget.temprature);
            });
          },
          child: Container(
            width: 55.w,
            height: 28.h,
            margin: EdgeInsets.only(
              left: 160.w,
            ),
            child: Image(
              width: 28.w,
              height: 28.h,
              image: AssetImage('images/home/temp.png'),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 0.w),
          child: Text(
            !widget.isToolOn ? '' : '${widget.temprature} °C',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
              color: Color(0xFFEFFAF6),
            ),
          ),
        ),
      ],
    );
  }
}
