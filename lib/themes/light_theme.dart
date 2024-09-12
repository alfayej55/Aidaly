// import 'package:flutter/material.dart';
//
// ThemeData light({Color color = const Color(0xFF039D55)}) => ThemeData(
//   fontFamily: 'Roboto',
//   primaryColor: color,
//   secondaryHeaderColor: Color(0xFF1ED7AA),
//   disabledColor: Color(0xFFBABFC4),
//   brightness: Brightness.light,
//
//   hintColor: Color(0xFF9F9F9F),
//   cardColor: Colors.white,
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: Colors.white,
//     elevation: 5,
//   ),
//
//   textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)),
//   colorScheme: ColorScheme.light(primary: color, secondary: color).copyWith(background: const Color(0xFFF3F3F3)).copyWith(error: Color(0xFFE84D4F)),
// );


import 'package:aidaly/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


ThemeData light({Color color = const Color(0xFF1E66CA)}) => ThemeData(
  fontFamily: 'Poppins',
  primaryColor: color,
  scaffoldBackgroundColor:const Color(0xFFECF4FF),
  secondaryHeaderColor: AppColors.secandaryTextColor,
  disabledColor:AppColors.subTextColor,
  brightness: Brightness.dark,
  hintColor:AppColors.hintColor,
  cardColor:AppColors.cardColor,
  dividerColor: AppColors.dividerColor,
  shadowColor: AppColors.shadowColor,
  canvasColor: AppColors.bottomBarColor,


  inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.fillColor,
      hintStyle: TextStyle(color:AppColors.hintColor,fontSize:16.sp),
      isDense: true,
      contentPadding:EdgeInsets.symmetric(
          horizontal:12.w,
          vertical: 16.h
      ),
      enabledBorder: enableBorder(),
      focusedBorder: focusedBorder(),
      errorBorder:errorBorder()

  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    backgroundColor:AppColors.whiteColor,
    unselectedItemColor: AppColors.textColor,
    selectedLabelStyle: TextStyle(color:color),
    unselectedLabelStyle: const TextStyle(color:Colors.red),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColors.backButtonColor
    )
  ),
  iconTheme: IconThemeData(
      color: AppColors.backButtonColor
  ),

  textTheme: TextTheme(
  bodySmall: TextStyle(color:AppColors.textColor),
  bodyLarge: TextStyle(color:AppColors.textColor),
  bodyMedium: TextStyle(color:AppColors.textColor),
  ).apply(
    bodyColor: AppColors.textColor,
    displayColor: AppColors.subTextColor,

  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)),
  colorScheme: ColorScheme.dark(primary: color, secondary: color).copyWith(background: Color(0xFF343636)).copyWith(error: Color(0xFFdd3135)),
);

OutlineInputBorder enableBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide: BorderSide(
      color: AppColors.primaryColor.withOpacity(0.1),
    ),


  );
}
OutlineInputBorder focusedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide:BorderSide(
      color: AppColors.primaryColor,
    ),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide:const BorderSide(
      color: Colors.red,
    ),
  );
}