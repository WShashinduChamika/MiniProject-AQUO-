import 'package:aquo/screens/home.dart';
import 'package:aquo/screens/signin.dart';
import 'package:aquo/services/authenticate.dart';
import 'package:aquo/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OTPVerification extends StatefulWidget {
  final bool isSignup;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  const OTPVerification(
      {super.key,
      required this.isSignup,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.phoneNumber});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _otpCode = TextEditingController();
  String receviedOTP = '';
  //String phoneNumber = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthServices _auth2 = AuthServices();
  String verificationReceivedId = '';
  bool isOTPVisible = false;
  DatabaseServices _db = DatabaseServices();

  final defaultPinTheme = PinTheme(
    width: 40.w,
    height: 50.h,
    textStyle: TextStyle(
      fontSize: 22.sp,
      color: Colors.white,
    ),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF).withOpacity(0.25),
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: Colors.transparent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: 812.h,
          width: 375.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 20.h,
                  width: 10.w,
                  margin: EdgeInsets.only(top: 32.h, left: 30.w),
                  //color:Colors.amber,
                  child: Image(
                      image:
                          const AssetImage("images/otp_screen/left_arrow.png"),
                      height: 20.h,
                      width: 10.w),
                ),
              ),
              Container(
                height: 255.h,
                width: 312.w,
                margin: EdgeInsets.only(left: 32.w),
                child: Image(
                  image: AssetImage("images/otp_screen/girl.png"),
                  height: 255.h,
                  width: 312.w,
                ),
              ),
              Container(
                height: 27.h,
                width: 200.w,
                margin: EdgeInsets.only(
                  left: 32.w,
                ),
                child: Row(
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage("images/otp_screen/TICK.png"),
                        height: 20.99.h,
                        width: 20.87.w,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "CONFIRMATION",
                        style: TextStyle(
                          color: const Color(0xFF5178F1),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.h,
                width: 295.w,
                margin: EdgeInsets.only(left: 32.w, top: 20.h),
                child: Row(
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage("images/otp_screen/SMARTPHONE.png"),
                        height: 42.h,
                        width: 25.w,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Please type the verification",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF5178F1),
                            ),
                          ),
                          Text(
                            "code sent to +94 ${hideNumber(widget.phoneNumber)}",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF5178F1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100.h,
                width: 315.w,
                margin: EdgeInsets.only(left: 32.w, top: 40.h),
                decoration: BoxDecoration(
                  color: Color(0xFF4553C6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.r),
                  ),
                ),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: Colors.blue.shade100)),
                  ),
                  onCompleted: (value) {
                    debugPrint(value);
                    setState(() {
                      receviedOTP = value;
                    });
                  },
                ),
              ),
              Container(
                height: 50.h,
                width: 315.w,
                margin: EdgeInsets.only(
                  top: 70.h,
                  left: 32.w,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    !isOTPVisible ? verifyNumber() : verifyCode();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF4553C6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.232.r),
                    ),
                  ),
                  child: Text(
                    !isOTPVisible ? 'Get OTP code' : 'Verify OTP',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void initState() async {
  //   super.initState();
  //   final user = await _auth.currentUser;
  //   DocumentSnapshot documentSnapshot = await _db.getUser(user!.uid);
  //   phoneNumber = documentSnapshot['phoneNumber'];
  // }

  void verifyNumber() {
    _auth.verifyPhoneNumber(
        phoneNumber: '+94${widget.phoneNumber.substring(1)}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) {
            print("Login suucessfully");
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          print('err $exception.message');
        },
        codeSent: (String verificationId, int? resendCode) {
          verificationReceivedId = verificationId;
          isOTPVisible = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  void verifyCode() async {
    print('Verify code');
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationReceivedId, smsCode: receviedOTP);
       await _auth.signInWithCredential(credential).then((value) async =>
         widget.isSignup
        ? await _auth2.signUpWithEmailPassword(
            widget.firstName,
            widget.lastName,
            widget.email,
            widget.password,
            widget.confirmPassword,
            widget.phoneNumber,
            context)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          )
        );
  }

  String hideNumber(String number) {
    String firstNumber = number.substring(1, 2);
    String middleNumbers = "* *** **";
    String lastNumbers = number.substring(number.length - 2);

    String hideNumber = "$firstNumber$middleNumbers$lastNumbers";

    return hideNumber;
  }
}
