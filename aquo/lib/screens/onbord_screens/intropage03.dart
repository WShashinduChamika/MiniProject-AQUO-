import 'package:flutter/material.dart';

class IntroPage03 extends StatefulWidget {
  const IntroPage03({super.key});

  @override
  State<IntroPage03> createState() => _IntroPage03State();
}

class _IntroPage03State extends State<IntroPage03> {
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
                image: const AssetImage('images/onbord_screens/Intro3.png'),
              ),
            ),
            Positioned(
              top: height * 0.669,
              left: width * 0.274,
              child: const Text(
                'Get Information',
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
                  'you can scan information of your plant or a pest that harm your plant and get information how to take care that problems.',
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
