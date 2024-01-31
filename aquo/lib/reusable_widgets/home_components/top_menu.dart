import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopMenu extends StatefulWidget {
  final Function(bool) isMenuClickedValue;
  final bool isClicked;
  const TopMenu(
      {super.key, required this.isMenuClickedValue, required this.isClicked});

  @override
  State<TopMenu> createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              bool udpateValue = !widget.isClicked;
              widget.isMenuClickedValue(udpateValue);
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 4.w),
            child: Image(
              height: 20.h,
              width: 20.w,
              image: AssetImage('images/home/menu.png'),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 113.w),
          child: Text(
            'Home',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFEFFAF6),
            ),
          ),
        ),
      ],
    );
  }
}
