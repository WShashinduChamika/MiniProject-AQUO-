import 'package:aquo/screens/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Container(
        height: 812.h,
        width: 375.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 40.h),
              child: Text(
                "Please enter your email ",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5178F1),
                ),
              ),
            ),
            Container(
              height: 120.h,
              width: 300.w,
              //color: Colors.amber,
              child: TextFormField(
                // Use TextFormField instead of TextField

                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.white,
                controller: _emailController,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Color.fromARGB(255, 7, 3, 3),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 10.0, top: 20.h, bottom: 20.h),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    fontFamily: 'Lato',
                    color: Color.fromARGB(255, 12, 2, 2),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 31, 20, 180),
                      width: 2.w,
                    ),
                    borderRadius:
                        BorderRadius.circular(10.0), // Set border radius here
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 49, 8, 199), width: 2.w),
                    borderRadius:
                        BorderRadius.circular(10.0), // Set border radius here
                  ),
                ),
              ),
            ),
            Container(
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4553C6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.232.r),
                  ),
                ),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SigninScreen()),
      );
    } on FirebaseException catch (e) {
      print(e.toString());
      _showForgotPasswordErrorDialog(e.toString());
    }
  }

  void _showForgotPasswordErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Error",
            style: TextStyle(
              color: Color.fromARGB(255, 71, 12, 82),
            ),
          ),
          content: Text(
            '$error',
            style: const TextStyle(
              color: Color.fromARGB(255, 71, 12, 82),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showForgotPasswordSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Success!!",
            style: TextStyle(
              color: Color.fromARGB(255, 71, 12, 82),
            ),
          ),
          content: Text(
            'Password is successfully reseted',
            style: const TextStyle(
              color: Color.fromARGB(255, 71, 12, 82),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
