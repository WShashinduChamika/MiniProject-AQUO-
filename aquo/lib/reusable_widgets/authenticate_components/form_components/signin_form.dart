import 'package:aquo/reusable_widgets/authenticate_components/form_components/text_field.dart';
import 'package:aquo/screens/home.dart';
import 'package:flutter/material.dart';
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
            ),
            UserInputField(
              controller: _passwordController,
              isPasswordType: true,
              hintText: 'Password',
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
                Container(
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
              ],
            ),
            SizedBox(
              height: 1.624.h,
            ),
            SizedBox(
              width: 131.w,
              height: 32.h,
              child: ElevatedButton(
                onPressed: () {
                  print(_userNameController.text);
                  print(_passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFFFFFF),
                  onPrimary: const Color(0xFF5A66D5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.232.r),
                  ),
                ),
                child: Text(
                  'Sign in',
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
                    height: 21.436.h,
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
                    onTap: () {},
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
}
