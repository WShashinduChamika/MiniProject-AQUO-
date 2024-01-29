import 'package:aquo/reusable_widgets/authenticate_components/form_components/signup_form.dart';
import 'package:aquo/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:aquo/reusable_widgets/authenticate_components/clippath_components/clip_path01.dart';
import 'package:aquo/reusable_widgets/authenticate_components/clippath_components/clip_path02.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ClipPath(
            clipper: SignInCliper01(),
            child: Container(
              height: 730.8.h,
              width: 375.w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4553C6),
                    Color(0xFF5178F1),
                  ],
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: SignInCliper02(),
            child: Container(
              height: 812.h,
              width: 375.w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(205, 69, 84, 198),
                    Color.fromARGB(198, 81, 121, 241),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 0.h),
                    width: 335.w,
                    height: 48.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigateSignIn(context);
                          },
                          child: Image(
                            height: 20.h,
                            width: 10.w,
                            image: const AssetImage(
                                'images/sign_in/left_arrow.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SignupForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateSignIn(BuildContext context) {
    print("Signup");
    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => const SigninScreen(),
      ),
    );
  }
}
