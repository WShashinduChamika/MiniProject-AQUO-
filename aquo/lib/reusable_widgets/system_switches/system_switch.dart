import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SystemSwitch extends StatefulWidget {
  final bool isMainSwitchOn;
  final bool isSwitchOn;
  final Function(bool) isSwitchOnValue;
  final String systemType;
  const SystemSwitch(
      {super.key,
      required this.isMainSwitchOn,
      required this.isSwitchOn,
      required this.isSwitchOnValue,
      required this.systemType});

  @override
  State<SystemSwitch> createState() => _SystemSwitchState();
}

class _SystemSwitchState extends State<SystemSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      width: 329.w,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 27.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.systemType,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Successfully completed',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.isMainSwitchOn
                ? () {
                    setState(() {
                      bool updateValue = !widget.isSwitchOn;
                      widget.isSwitchOnValue(updateValue);
                    });
                  }
                : () {},
            child: Container(
              margin: EdgeInsets.only(left: 122.w),
              height: 30.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: !widget.isSwitchOn
                    ? const Color(0xFFCCCCCC)
                    : const Color(0xFF4CD964),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: !widget.isSwitchOn
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Container(
                    //margin: EdgeInsets.only(left: !isFertilizerSwitchOn?0.w:),
                    height: 30.h,
                    width: 30.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
