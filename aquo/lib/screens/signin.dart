import 'package:aquo/reusable_widgets/authenticate_components/clippath_components/clip_path01.dart';
import 'package:aquo/reusable_widgets/authenticate_components/clippath_components/clip_path02.dart';
import 'package:aquo/reusable_widgets/authenticate_components/form_components/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
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
                    height: 64.h,
                  ),
                  const SiginForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
