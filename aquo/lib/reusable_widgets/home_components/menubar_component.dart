import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuBarComponent extends StatefulWidget {
  final bool isClicked;
  final Function(bool) isClickedValueChanges;
  final Function buttonBehaviour;
  final double top;
  final String img;
  const MenuBarComponent(
      {super.key,
      required this.isClicked,
      required this.isClickedValueChanges,
      required this.top,
      required this.buttonBehaviour,
      required this.img});

  @override
  State<MenuBarComponent> createState() => _MenuBarComponentState();
}

class _MenuBarComponentState extends State<MenuBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10.w,
      top: widget.top,
      child: IconButton(
        onPressed: () {
          widget.buttonBehaviour();
          setState(() {
            bool updateValue = !widget.isClicked;
            widget.isClickedValueChanges(updateValue);
          });
        },
        icon: Image(
          height: 20.h,
          width: 18.w,
          image: AssetImage(widget.img),
        ),
      ),
    );
    ;
  }
}
