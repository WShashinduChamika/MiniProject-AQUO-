import 'package:aquo/reusable_widgets/home_components/menubar_component.dart';
import 'package:aquo/screens/future_implement.dart';
import 'package:aquo/screens/map.dart';
import 'package:aquo/screens/notiscreen.dart';
import 'package:aquo/screens/user.dart';
import 'package:aquo/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBar extends StatefulWidget {
  final bool isMenuBarClicked;
  final Function(bool) isMenuBarClickedValue;
  const NavBar(
      {super.key,
      required this.isMenuBarClicked,
      required this.isMenuBarClickedValue});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.isMenuBarClicked ? 0.w : -72.w,
      top: 0.h,
      child: Container(
        height: 812.h,
        width: 72.w,
        color: const Color(0xFF5178F1),
        child: Stack(
          children: [
            MenuBarComponent(
                isClicked: widget.isMenuBarClicked,
                isClickedValueChanges: (value) {
                  setState(() {
                    bool updatedvalue = !widget.isMenuBarClicked;
                    widget.isMenuBarClickedValue(updatedvalue);
                  });
                },
                top: 5.h,
                buttonBehaviour: () {
                  //print('hello');
                },
                img: 'images/home/blog.png'),
            MenuBarComponent(
                isClicked: widget.isMenuBarClicked,
                isClickedValueChanges: (value) {
                  setState(() {
                    bool updatedvalue = !widget.isMenuBarClicked;
                    widget.isMenuBarClickedValue(updatedvalue);
                  });
                },
                top: 65.h,
                buttonBehaviour: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FutureImplementScreen()),
                  );
                },
                img: 'images/home/clock.png'),
            MenuBarComponent(
                isClicked: widget.isMenuBarClicked,
                isClickedValueChanges: (value) {
                  setState(() {
                    bool updatedvalue = !widget.isMenuBarClicked;
                    widget.isMenuBarClickedValue(updatedvalue);
                  });
                },
                top: 125.h,
                buttonBehaviour: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FutureImplementScreen()),
                  );
                },
                img: 'images/home/help.png'),
            MenuBarComponent(
                isClicked: widget.isMenuBarClicked,
                isClickedValueChanges: (value) {
                  setState(() {
                    bool updatedvalue = !widget.isMenuBarClicked;
                    widget.isMenuBarClickedValue(updatedvalue);
                  });
                },
                top: 185.h,
                buttonBehaviour: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfile(),
                    ),
                  );
                },
                img: 'images/home/user.png'),
            MenuBarComponent(
                isClicked: widget.isMenuBarClicked,
                isClickedValueChanges: (value) {
                  setState(() {
                    bool updatedvalue = !widget.isMenuBarClicked;
                    widget.isMenuBarClickedValue(updatedvalue);
                  });
                },
                top: 245.h,
                buttonBehaviour: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()),
                  );
                },
                img: 'images/home/notification.png'),
            MenuBarComponent(
                isClicked: widget.isMenuBarClicked,
                isClickedValueChanges: (value) {
                  setState(() {
                    bool updatedvalue = !widget.isMenuBarClicked;
                    widget.isMenuBarClickedValue(updatedvalue);
                  });
                },
                top: 640.h,
                buttonBehaviour: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FutureImplementScreen()),
                  );
                },
                img: 'images/home/question.png'),
            MenuBarComponent(
                isClicked: widget.isMenuBarClicked,
                isClickedValueChanges: (value) {
                  setState(() {
                    bool updatedvalue = !widget.isMenuBarClicked;
                    widget.isMenuBarClickedValue(updatedvalue);
                  });
                },
                top: 700.h,
                buttonBehaviour: () async {
                  final AuthServices _auth = AuthServices();
                  await _auth.signOut(context);
                },
                img: 'images/home/logout.png'),
          ],
        ),
      ),
    );
  }
}
