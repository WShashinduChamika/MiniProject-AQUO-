import 'package:aquo/reusable_widgets/authenticate_components/form_components/text_field.dart';
import 'package:aquo/screens/otp.dart';
import 'package:aquo/screens/signin.dart';
import 'package:aquo/services/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  bool isSignup = false;
  AuthServices _auth = AuthServices();

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
              height: 50.h,
            ),
            UserInputField(
              controller: _firstNameController,
              isPasswordType: false,
              hintText: 'First Name',
              isPhoneType: false,
            ),
            UserInputField(
              controller: _lastNameController,
              isPasswordType: false,
              hintText: 'Last Name',
              isPhoneType: false,
            ),
            UserInputField(
              controller: _emailController,
              isPasswordType: false,
              hintText: 'Email',
              isPhoneType: false,
            ),
            UserInputField(
              controller: _passwordController,
              isPasswordType: true,
              hintText: 'Password',
              isPhoneType: false,
            ),
            UserInputField(
              controller: _confirmPasswordController,
              isPasswordType: true,
              hintText: 'Confirm Password',
              isPhoneType: false,
            ),
            UserInputField(
              controller: _phoneNumberController,
              isPasswordType: false,
              hintText: 'Contact Number',
              isPhoneType: true,
            ),
            SizedBox(
              height: 25.h,
            ),
            SizedBox(
              width: 131.w,
              height: 35.h,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isSignup = true;
                  });
                  checkAuthentication(
                      _firstNameController.text,
                      _lastNameController.text,
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text,
                      _phoneNumberController.text,
                      context);
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() {
                    isSignup = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF5A66D5),
                  backgroundColor: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.232.r),
                  ),
                ),
                child: !isSignup
                    ? Text(
                        'Sign up',
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
              height: 10.h,
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
                  SizedBox(
                    height: 21.46.h,
                    width: 19.98.w,
                    child: Image(
                      height: 21.h,
                      width: 20.w,
                      image: const AssetImage('images/sign_in/fb.png'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 23.h,
            ),
            Container(
              width: 236.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateSignIn(context);
                    },
                    child: Text(
                      "Login now",
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

  void navigateSignIn(BuildContext context) {
    print("Signup");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SigninScreen(),
      ),
    );
  }

  void checkAuthentication(
      String firstName,
      String lastName,
      String email,
      String password,
      String confirmPassword,
      String phoneNumber,
      BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerification(
          isSignup: true,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          phoneNumber: phoneNumber,
        ),
      ),
    );

    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
  }

  // void validateEmail(String value) {
  //   if (value == null || value.isEmpty) {
  //     setState(() {
  //       emailError = null;
  //     });
  //     // setState(() {
  //     //   emailError = 'Email is required';
  //     // });
  //   } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
  //       .hasMatch(value)) {
  //     setState(() {
  //       emailError = "Email is not valid";
  //     });
  //   } else {
  //     setState(() {
  //       emailError = null;
  //     });
  //   }
  // }

  // void checkPasswordStrength(String value) {
  //   if (value.length < 8 && value.length >= 1) {
  //     setState(() {
  //       passwordError = 'Password must be at least 8 characters';
  //     });
  //   } else if (value.length == 0) {
  //     setState(() {
  //       passwordError = null;
  //     });
  //   } else if (!RegExp(r'[a-z]').hasMatch(value)) {
  //     setState(() {
  //       passwordError = 'Password must contain at least one lowercase letter';
  //     });
  //   } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
  //     setState(() {
  //       passwordError = 'Password must contain at least one uppercase letter';
  //     });
  //   } else if (!RegExp(r'\d').hasMatch(value)) {
  //     setState(() {
  //       passwordError = 'Password must contain at least one digit';
  //     });
  //   } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
  //     setState(() {
  //       passwordError = 'Password must contain at least one special character';
  //     });
  //   } else {
  //     setState(() {
  //       passwordError = null;
  //     });
  //   }
  // }

  // void checkConfirmPassword(String value) {
  //   if (value != _passwordController.text) {
  //     setState(() {
  //       confirmPasswordError = 'Password does not matched';
  //     });
  //   } else {
  //     setState(() {
  //       confirmPasswordError = null;
  //     });
  //   }
  // }
}
