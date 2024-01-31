import 'package:aquo/reusable_widgets/home_components/navbar.dart';
import 'package:aquo/reusable_widgets/home_components/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMenuBarClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: isMenuBarClicked ? 0.6 : 1.0,
              child: Container(
                width: 375.w,
                height: 812.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF4553C6),
                      Color(0xFF5178F1),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 48.h,
                      width: 329.w,
                      margin: EdgeInsets.only(top: 0.h),
                      //color: Colors.amberAccent,
                      child: TopMenu(
                          isMenuClickedValue: (value) {
                            setState(() {
                              isMenuBarClicked = value;
                            });
                          },
                          isClicked: isMenuBarClicked),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                  ],
                ),
              ),
            ),
            NavBar(
              isMenuBarClicked: isMenuBarClicked,
              isMenuBarClickedValue: (value) {
                setState(() {
                  isMenuBarClicked = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
