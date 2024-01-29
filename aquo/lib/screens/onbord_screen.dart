import 'package:aquo/screens/home.dart';
import 'package:aquo/screens/onbord_screens/intropage01.dart';
import 'package:aquo/screens/onbord_screens/intropage02.dart';
import 'package:aquo/screens/onbord_screens/intropage03.dart';
import 'package:aquo/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordScreen extends StatefulWidget {
  const OnbordScreen({super.key});

  @override
  State<OnbordScreen> createState() => _OnbordScreenState();
}

class _OnbordScreenState extends State<OnbordScreen> {
  double width = 0.0;
  double height = 0.0;
  PageController _controller = PageController();
  bool isLastPage = false;
  bool hasBackPage = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //Text skip = Text('Skip');
    String skip = "Skip";
    isLastPage ? skip = '' : skip = skip;

    return Scaffold(
      // ignore: sized_box_for_whitespace
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 2);
                hasBackPage = (index == 1 || index == 2);
              });
            },
            children: const [
              IntroPage01(),
              IntroPage02(),
              IntroPage03(),
            ],
          ),

          //to page indicator

          Positioned(
            top: height * 0.623,
            left: width * 0.4,
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xff4553C6),
                dotColor: Color(0xffD2D8CF),
                dotHeight: 8.0,
                dotWidth: 8.0,
                spacing: 16.0,
              ),
            ),
          ),

          Positioned(
            left: hasBackPage ? width * 0.08 : width * (-2.0),
            top: height * 0.05,
            child: GestureDetector(
              onTap: () {
                _controller.previousPage(
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeIn);
              },
              child: const Image(
                image: AssetImage('images/onbord_screens/BackArrow.png'),
              ),
            ),
          ),

          !isLastPage
              ? Positioned(
                  top: height * 0.817,
                  left: width * 0.0426,
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * 0.914, height * 0.0591),
                      backgroundColor: const Color.fromARGB(255, 52, 95, 195),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Positioned(
                  top: height * 0.885,
                  left: width * 0.0426,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * 0.914, height * 0.0591),
                      backgroundColor: const Color.fromARGB(255, 52, 95, 195),
                    ),
                    child: const Text(
                      "Let's Get Started",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.01,
                        wordSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

          //to space between next button and skip text

          Positioned(
            top: height * 0.9,
            left: width * 0.464,
            child: GestureDetector(
              onTap: () {
                _controller.jumpToPage(2);
              },
              child: Text(
                skip,
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff4553C6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
