import 'package:aquo/screens/home.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void _handleArrow() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/start_screen/splashbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        //ignore: avoid_unnecessary_containers
        child: Stack(
          children: [
            Positioned(
              top: height * 0.039,
              left: width * 0.072,
              child: Container(
                height: height * 0.0246,
                width: width * 0.0533,
                //color: Colors.amber,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/start_screen/squareIcon.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.777,
              child: Container(
                alignment: const Alignment(-0.5, 0),
                height: height * 0.114,
                width: width * 0.68,
                color: const Color(0xffBEC8B8),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: height * 0.022,
                    ),
                    children: const [
                      TextSpan(text: 'Agriculture to your\n'),
                      TextSpan(text: 'Fingertips'),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.69,
              left: width * 0.68,
              child: Container(
                height: height * 0.2,
                width: width * 0.16,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/start_screen/AQUO.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.85,
              left: width * 0.344,
              child: GestureDetector(
                onTap: _handleArrow,
                child: Container(
                  height: height * 0.086,
                  width: width * 0.186,
                  color: const Color(0xff2D3934),
                  child: const Image(
                    image: AssetImage('images/start_screen/RIGHTARROW.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
