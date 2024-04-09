import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UserInputField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPasswordType;
  final String hintText;
  final bool isPhoneType;

  const UserInputField({
    Key? key,
    required this.controller,
    required this.isPasswordType,
    required this.hintText,
    required this.isPhoneType,
  }) : super(key: key);

  @override
  State<UserInputField> createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 375.w * 0.05,
        right: 375.w * 0.05,
      ),
      child: Container(
        height: 35.h,
        child: TextFormField(
          // Use TextFormField instead of TextField

          keyboardType:
              widget.isPhoneType ? TextInputType.phone : TextInputType.text,
          cursorColor: Colors.white,
          controller: widget.controller,
          obscureText:
              !_obscureText ? widget.isPasswordType : !widget.isPasswordType,
          autocorrect: !widget.isPasswordType,
          enableSuggestions: !widget.isPasswordType,
          style: TextStyle(
            fontFamily: 'Lato',
            color: const Color(0xffFFFFFF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            suffixIcon: widget.isPasswordType
                ? IconButton(
                    icon: Icon(
                      !_obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null, // Removed unnecessary IconButton for non-password fields
            contentPadding: EdgeInsets.only(left: 5.0),
            hintText: '${widget.hintText}:',
            hintStyle: TextStyle(
              fontFamily: 'Lato',
              color: const Color(0xffFFFFFF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFFFFF)),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 214, 212, 212)),
            ),
          ),
        ),
      ),
    );
  }
}
