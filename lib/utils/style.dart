import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class AppStyles {
  static TextStyle h1(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: 24.sp,
        fontFamily: 'Poppins',
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w600);
  }

  static TextStyle h2(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: 22.sp,
        fontFamily: 'Poppins',
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w600);
  }

  static TextStyle h3({
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,

  }) {
    return TextStyle(
        color: color,
        fontSize: 17.sp,
        letterSpacing: letterSpacing,
        fontFamily: 'Poppins',
        fontWeight: fontWeight ?? FontWeight.w700);
  }

  static TextStyle h4(
      {Color? color,
        FontWeight? fontWeight,
        double? letterSpacing,
        double? height}) {
    return TextStyle(
        fontSize: 17.sp,
        fontFamily: 'Poppins',
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle h5(
      {Color? color,
        FontWeight? fontWeight,
        double? letterSpacing,
        double? height}) {
    return TextStyle(
        fontSize: 14.sp,
        fontFamily: 'Poppins',
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle h6(
      {Color? color,
        FontWeight? fontWeight,
        double? letterSpacing,
        double? height}) {
    return TextStyle(
        fontSize: 12.sp,
        fontFamily: 'Poppins',
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w500);
  }

  static TextStyle h7({
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,

  }) {
    return TextStyle(
        color: color,
        fontSize: 18.sp,
        letterSpacing: letterSpacing,
        fontFamily: 'Poppins',
        fontWeight: fontWeight ?? FontWeight.w600);
  }

  static TextStyle h8({
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,

  }) {
    return TextStyle(
        color: color,
        fontSize: 16.sp,
        letterSpacing: letterSpacing,
        fontFamily: 'Poppins',
        fontWeight: fontWeight ?? FontWeight.w500);
  }

  static TextStyle customSize(
      {Color? color,
        required double size,
        String? family,
        double? letterSpacing,
        double? height,
        TextDecoration? underline,
        Color? underlineColor,
         FontStyle? fontstyle,
        FontWeight? fontWeight}) {
    return TextStyle(
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color,
        fontFamily: 'Poppins',
        fontStyle: fontstyle?? FontStyle.normal,
        fontSize: size,
        decoration: underline ?? TextDecoration.none,
        decorationColor: underlineColor??Colors.transparent,
        height: height,
        decorationThickness: 2.0,
        letterSpacing: letterSpacing,
       );
  }

  static BoxShadow boxShadow =  BoxShadow(
      blurRadius: 4,
      offset: const Offset(0,0),
      color:Colors.black.withOpacity(0.02),
      spreadRadius:0);

  static BoxShadow boutiqueboxShadow =  BoxShadow(
      blurRadius: 128,
      offset: const Offset(0,39),
      color:Color(0xFFEBEBEB),
      spreadRadius:0);

  static BoxShadow boutiqueCircleboxShadow =  BoxShadow(
      blurRadius: 8,
      offset: const Offset(0,2),
      color:Color(0xFF000000).withOpacity(0.5),
      spreadRadius:0);

  // static BoxShadow floatingboutiqueCircleboxShadow =   BoxShadow(
  //     blurRadius: 57.79,
  //     offset: const Offset(0,0),
  //     color:Color(0xFF000000).withOpacity(1.5),
  //     spreadRadius:3.72);



}