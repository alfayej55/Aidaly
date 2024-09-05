import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColors{




  static Color primaryColor=const Color(0xFF1E66CA);
  static Color backgroundColor=const Color(0xFF010101);
  static Color cardColor = const Color(0xFFFFFFFF);
  static Color cardLightColor = const Color(0xFF555555);


  static Color textColor = const Color(0xFF2C2C2C);
  static Color subTextColor = const Color(0xFF2C2C2C);
  static Color secandaryTextColor = const Color(0xFF8DB501);
  static Color onboardintSubTextColor = const Color(0xFFDFDFDF);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color borderColor = const Color(0xFF1E66CA);
  static Color hintColor = const Color(0xFF2C2C2C);
  static Color greyColor = const Color(0xFFB5B5B5);
  static Color fillColor = const Color(0xFFE9F3FD).withOpacity(0.3);
  static Color dividerColor = const Color(0xFF555555);
  static Color shadowColor = const Color(0xFF1E66CA).withOpacity(0.1);
  static Color bottomBarColor = const Color(0xFF343434);
  static Color backButtonColor = const Color(0xFF2C2C2C);
  static Color bodygradientColor = const Color(0xFFECF4FF);
  static Color bodygradientColor2 = const Color(0xFFFFFFFF);
  static Color iconCartColor = const Color(0xFF735E4F);

  static BoxShadow shadow=BoxShadow(
    blurRadius: 12,
    spreadRadius: 0,
    color: shadowColor,
    offset: const Offset(0, 4),
  );
}