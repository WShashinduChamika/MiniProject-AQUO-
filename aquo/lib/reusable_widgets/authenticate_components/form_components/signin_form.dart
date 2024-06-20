import 'package:aquo/global.dart';
import 'package:aquo/reusable_widgets/authenticate_components/form_components/text_field.dart';
import 'package:aquo/screens/default_home.dart';
import 'package:aquo/screens/forgot_password.dart';
import 'package:aquo/screens/home.dart';
import 'package:aquo/screens/otp.dart';
import 'package:aquo/screens/signup.dart';
import 'package:aquo/services/authenticate.dart';
import 'package:aquo/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SiginForm extends StatefulWidget {
  const SiginForm({super.key});

  @override
  State<SiginForm> createState() => _SiginFormState();
}

class _SiginFormState extends State<SiginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool? isChecked = false;
  bool isSignin = false;
  final AuthServices _auth = AuthServices();
  final DatabaseServices _db = DatabaseServices();
  String contactNumber = "";

  Map<String, dynamic>? _userData;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 649.6.h,
        width: 281.25.w,
        child: Column(
          children: [
            SizedBox(
              height: 68.h,
            ),
            Image(
              height: 64.h,
              width: 64.w,
              image: const AssetImage('images/sign_in/user.png'),
            ),
            SizedBox(
              height: 114.h,
            ),
            UserInputField(
              controller: _userNameController,
              isPasswordType: false,
              hintText: 'User name',
              isPhoneType: false,
            ),
            UserInputField(
              controller: _passwordController,
              isPasswordType: true,
              hintText: 'Password',
              isPhoneType: false,
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      isChecked = newValue;
                    });
                  },
                ),
                Container(
                  //margin: EdgeInsets.only(right: (width * 0.2)),
                  child: Text(
                    'Remember Password',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFFBDC1BB),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: (7.5.w)),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFEFFAF6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.624.h,
            ),
            SizedBox(
              width: 131.w,
              height: 32.h,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isSignin = true;
                  });
                  checkAuthentication(_userNameController.text,
                      _passwordController.text, context);
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {
                    isSignin = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF5A66D5),
                  backgroundColor: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.232.r),
                  ),
                ),
                child: !isSignin
                    ? Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Container(
                        height: 25.h,
                        width: 25.w,
                        child: const CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              'Sign in with',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 14.sp,
                color: const Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Container(
              width: 63.75.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      UserCredential? user =
                          await _auth.signInWithGoogle(context);
                      print(user);
                    },
                    child: SizedBox(
                      height: 21.46.h,
                      width: 19.98.w,
                      child: Image(
                        height: 21.h,
                        width: 20.w,
                        image: const AssetImage('images/sign_in/google.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      UserCredential? user = await signInWithFacebook();
                      if (user != null) {
                        isFacebookUser = true;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DefaultHomeScreen()));
                      }
                    },
                    child: SizedBox(
                      height: 21.436.h,
                      width: 19.98.w,
                      child: Image(
                        height: 21.h,
                        width: 20.w,
                        image: const AssetImage('images/sign_in/fb.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 23.h,
            ),
            Container(
              width: 205.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      });
                      //navigateSignUp(context);
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14.sp,
                        color: const Color(0xFF80A994),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateSignUp(BuildContext context) {
    print("Signup");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  void checkAuthentication(
      String email, String password, BuildContext context) async {
    await _auth.signinWithEmailAndPassword(email, password, context);
    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result =
        await FacebookAuth.instance.login(permissions: ['email']);

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();

      _userData = userData;
    } else {
      print(result.message);
    }

    setState(() {
      //welcome = _userData?['email'];
    });

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
