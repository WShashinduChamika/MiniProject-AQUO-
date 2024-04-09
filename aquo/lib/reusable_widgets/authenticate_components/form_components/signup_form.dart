import 'package:aquo/reusable_widgets/authenticate_components/form_components/text_field.dart';
import 'package:aquo/screens/signin.dart';
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
            ),
            UserInputField(
              controller: _lastNameController,
              isPasswordType: false,
              hintText: 'Last Name',
            ),
            UserInputField(
              controller: _emailController,
              isPasswordType: false,
              hintText: 'Email',
            ),
            UserInputField(
              controller: _passwordController,
              isPasswordType: true,
              hintText: 'Password',
            ),
            UserInputField(
              controller: _confirmPasswordController,
              isPasswordType: true,
              hintText: 'Confirm Password',
            ),
            SizedBox(
              height: 25.h,
            ),
            SizedBox(
              width: 131.w,
              height: 32.h,
              child: ElevatedButton(
                onPressed: () {
                  print("Saved");
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF5A66D5),
                  backgroundColor: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.232.r),
                  ),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
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
                  SizedBox(
                    height: 21.46.h,
                    width: 19.98.w,
                    child: Image(
                      height: 21.h,
                      width: 20.w,
                      image: const AssetImage('images/sign_in/google.png'),
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
}
