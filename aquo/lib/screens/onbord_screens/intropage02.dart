import 'package:flutter/material.dart';

class IntroPage02 extends StatefulWidget {
  const IntroPage02({super.key});

  @override
  State<IntroPage02> createState() => _IntroPage02State();
}

class _IntroPage02State extends State<IntroPage02> {
  double height = 0.0;
  double width = 0.0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              left: 0.072,
              child: Image(
                height: height * 0.698,
                width: width * 0.858,
                image: const AssetImage('images/onbord_screens/Intro2.png'),
              ),
            ),
            Positioned(
              top: height * 0.669,
              left: width * 0.168,
              child: const Text(
                'Watering without worry',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Positioned(
              top: height * 0.73,
              left: width * 0.12,
              child: Container(
                width: width * 0.76,
                child: const Text(
                  'you can watering plant properly and can exchange schedule automatically if come a bad climate',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
