import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscure;
  final Color? filColor;
  final bool? readOnly;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final TextStyle? hindStyle;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;
  final bool isPassword;
  final bool enable;
  Function()? onTap;
  ValueChanged<String>? onChange;
  final bool? isEmail;
  final int? maxLine;

   CustomTextField(
      {super.key,
      this.contentPaddingHorizontal,
      this.contentPaddingVertical,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
        this.enable=true,
        this.readOnly,
      this.validator,
        this.hindStyle,
      this.isEmail,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.isObscureText = false,
      this.obscure = '*',
      this.filColor,
      this.labelText,
        this.onTap,
        this.onChange,
        this.maxLine,
      this.isPassword = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: widget.contentPaddingHorizontal?? 5),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscuringCharacter: widget.obscure!,
        maxLines: widget.maxLine ?? 1,
        readOnly: widget.readOnly ?? false,

        validator: widget.validator ?? (value) {
          if (widget.isEmail == null) {
            if (value!.isEmpty) {
              return "Please enter ${widget.hintText!.toLowerCase()}";
            } else if (widget.isPassword) {
              if (value.length < 8) {
                return "Password must be at least 8 characters long.";
              } else if (!AppConstants.passwordValidator.hasMatch(value)) {
                return "Insecure password detected.";
              }
            }
          } else {
            bool isValidEmail = AppConstants.emailValidator.hasMatch(value!);
            if (value.isEmpty) {
              return "Please enter ${widget.hintText!.toLowerCase()}";
            } else if (!isValidEmail) {
              return "Please check your email!";
            }
          }
          return null;
        },

        cursorColor: AppColors.primaryColor,
        obscureText: widget.isPassword ? obscureText : false,
        style: TextStyle(color: Get.theme.hintColor, fontSize: 16.sp),
        onTap: widget.onTap,
        onChanged: widget.onChange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: widget.contentPaddingHorizontal ?? 20.w,
              vertical: widget.contentPaddingVertical ?? 20.w),
          fillColor: widget.filColor,
          prefixIcon: widget.prefixIcon,
          hintStyle: widget.hindStyle,
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: toggle,
            child: _suffixIcon(
                obscureText ? Icons.visibility_off : Icons.visibility),
          )
              : widget.suffixIcon,
          prefixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
          suffixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
          labelText: widget.labelText,
          hintText: widget.hintText,
        ),
      )
    );
  }
  _suffixIcon(IconData icon) {
    return Padding(padding: const EdgeInsets.all(12.0), child: Icon(icon,color: Colors.grey,));
  }
}
